const { exec } = require("child_process");
const fs = require("fs");

const apiSchemaLocation = process.argv[2];

if (apiSchemaLocation == undefined) {
  throw new Error("Must specify a API schema path");
}

async function main() {
  const apiSchemaString = fs.readFileSync(apiSchemaLocation).toString();
  const apiSchema = JSON.parse(apiSchemaString);
  const { paths } = apiSchema;

  const { deprecatedPathMap, newerVersionPathMaps } =
    getSchemaDepreactedAndNewer(paths);

  const deprecatedEndpoints = await searchForRoutesInFolder(deprecatedPathMap);
  const newerVersionEndpoints = await searchForRoutesInFolder(
    newerVersionPathMaps
  );

  const results = formatResults({ deprecatedEndpoints, newerVersionEndpoints });

  fs.writeFileSync("./apis.json", results);
}

function getSchemaDepreactedAndNewer(paths) {
  const deprecatedPathMap = {};
  const newerVersionPathMaps = {};

  for (const pathString in paths) {
    const path = paths[pathString];

    // Check deprecated
    let isDeprecated = false;
    for (const verbString in path) {
      const route = path[verbString];
      const routeString = `${pathString}:${verbString}`;

      if (route.deprecated) {
        deprecatedPathMap[routeString] = route;
        isDeprecated = true;
        break;
      }
    }

    if (!isDeprecated) {
      // Check newer API version
      const pathParts = pathString.split("/");
      const version = pathParts[2];
      const versionNumber = Number(version.substring(1));
      const nextVersion = `v${versionNumber + 1}`;
      const nextPathParts = [...pathParts];
      nextPathParts[2] = nextVersion;
      const nextPathString = nextPathParts.join("/");

      const path = paths[nextPathString];
      for (const verbString in path) {
        const route = path[verbString];

        // Want the outdated version so use path string
        const routeString = `${pathString}:${verbString}`;

        newerVersionPathMaps[routeString] = route;
      }
    }
  }

  return {
    deprecatedPathMap,
    newerVersionPathMaps,
  };
}

async function searchForRoutesInFolder(routes) {
  const endpoints = [];

  for (routeString in routes) {
    const [route, verb] = routeString.split(":");
    const wildCardString = route.replace(new RegExp("{[^/]*}", "g"), ".+");

    const routePaths = wildCardString.split("/");

    const searchParts = routePaths.slice(2);
    const searchTerm = `${searchParts.join("/")}`;

    console.log("searching", searchTerm);
    const result = await searchRouteInFolder(searchTerm);

    if (result !== "") {
      endpoints.push(routeString);
    }
  }

  return endpoints;
}

function searchRouteInFolder(searchTerm) {
  return new Promise((res) => {
    const result = exec(`ag ${searchTerm} ./src`);

    let data = "";
    result.stdout.on("data", (chunk) => {
      data += chunk.toString();
    });

    result.on("exit", () => {
      if (data != "") {
        console.log(`Found: ${routeString}`);
      } else {
        console.info(`Could not find: ${searchTerm}`);
      }

      res(data);
    });
  });
}

function formatResults({ deprecatedEndpoints, newerVersionEndpoints }) {
  return `DEPRECATED TO CHECK

${deprecatedEndpoints.join("\n")}

NEWER VERSIONS TO CHECK

${newerVersionEndpoints.join("\n")}
  `;
}

main();
