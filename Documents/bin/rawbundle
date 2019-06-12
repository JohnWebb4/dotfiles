#------------------------------------------------------------------------------
# raw_bundle.sh
#
# Returns raw output from running bundler at localhost:8081
#
# Usage: raw_bundle.sh <target_line_number>
#------------------------------------------------------------------------------

TARGET_LINE=$1
START_LINE=$((TARGET_LINE-4))
LINE_COUNT=10

BUNDLE_OUTPUT=`curl -s http://localhost:8081/index.bundle\?platform\=ios\&dev\=true\&minify\=false | head -$START_LINE | tail -$LINE_COUNT`

echo ""

IFS=$'\n'
lineNumber=$START_LINE

for bundleLine in $BUNDLE_OUTPUT; do
  if [ $lineNumber == $TARGET_LINE ]; then
    color="\e[32m" # Highlight target line green
  fi

  printf "$color$lineNumber   $bundleLine\e[0m\n"

  lineNumber=$((lineNumber+1))
  color=""
done
