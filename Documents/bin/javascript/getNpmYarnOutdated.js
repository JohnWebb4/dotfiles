const { exec } = require("child_process");
const fs = require("fs");
const { differenceInDays } = require("date-fns");

const packageLocation = process.argv[2];

if (packageLocation == undefined) {
  throw new Error("Must specify a package.json path");
}

const packageString = fs.readFileSync(packageLocation).toString();
const package = JSON.parse(packageString);

const yarnLocation = process.argv[3];

if (yarnLocation == undefined) {
  throw new Error("Must specify a yarn.lock path");
}

const yarnLock = fs
  .readFileSync(yarnLocation)
  .toString()
  .split("\n\n")
  .map((dependency) => dependency.split("\n").map((l) => l.trim()));

function fetchDependencyInfo(dependency, version) {
  return new Promise((res, rej) => {
    const yarnDependencyIndex = yarnLock.findIndex((d) =>
      d[0].startsWith(`"${dependency}@npm:${version}`)
    );

    if (yarnDependencyIndex >= 0) {
      const currentVersion = yarnLock[yarnDependencyIndex][1]
        .trim()
        .split("version: ")[1];

      const result = exec(`npm view --json ${dependency}`);

      let data = "";
      result.stdout.on("data", (chunk) => {
        data += chunk.toString();
      });

      result.on("exit", () => {
        if (data != "") {
          const json = JSON.parse(data);

          dependencyVersions = Object.keys(json.time);
          const latestVersion =
            dependencyVersions[dependencyVersions.length - 1];

          const currentPublishDate = new Date(json.time[currentVersion]);
          const latestPublishDate = new Date(json.time[latestVersion]);

          const diffInDays = differenceInDays(
            latestPublishDate,
            currentPublishDate
          );

          res({
            dependency,
            currentVersion,
            latestVersion,
            currentPublishDate,
            latestPublishDate,
            diffInDays,
          });
        } else {
          rej(new Error(`Failed to fetch dependency from npm: ${dependency}`));
        }
      });
    } else {
      rej(
        new Error(`Failed to find dependency in yarn lock file: ${dependency}`)
      );
    }
  });
}

async function fetchAndFormatDependency(dependency, version) {
  try {
    dependencyInfo = await fetchDependencyInfo(dependency, version);

    console.log(dependencyInfo);

    return dependencyInfo;
  } catch (error) {
    console.error(error);

    return {
      dependency,
      error: error?.message,
    };
  }
}

async function run() {
  let dependenciesInfo = [];

  const dependencies = Object.keys(package.dependencies);

  const batchSize = 5;
  for (let i = 0; i < dependencies.length; i += batchSize) {
    const batch = [];

    for (let j = 0; j < batchSize && i + j < dependencies.length; j++) {
      const dependency = dependencies[i + j];

      batch.push(
        fetchAndFormatDependency(dependency, package.dependencies[dependency])
      );
    }

    batchResult = await Promise.all(batch);

    dependenciesInfo = dependenciesInfo.concat(batchResult);
  }

  dependenciesInfo.sort((d1, d2) => {
    if (isNaN(d1.diffInDays) && !isNaN(d2.diffInDays)) {
      return -1;
    }

    if (!isNaN(d1.diffInDays) && isNaN(d2.diffInDays)) {
      return 1;
    }

    return d2.diffInDays - d1.diffInDays;
  });

  fs.writeFileSync("./version.json", JSON.stringify(dependenciesInfo));
}

run();
