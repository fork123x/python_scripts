#/bin/bash
#
# Usage: dump task and files
# Author: xululu
#

TM_PATH="/home/work/tm_server"
DUMP_BIN="./tools/task_dumper"
PROTO_DIR="./proto/"
GROUP_NAME="ASPJoiner4reporter"
LIMIT=2
XML_FILE="./xululu/data/sandbox_asp_task_dump.xml"
NEW_XML_FILE="./xululu/data/sandbox_asp_task_dump_new.xml"
DATA_PATH="./xululu/data/"
SCRIPT_PATH="/home/work/tm_server/xululu"

cd ${TM_PATH}
${DUMP_BIN} -proto_path ${PROTO_DIR} -group_name "${GROUP_NAME}" -limit ${LIMIT} -output ${XML_FILE}
if [[ $? -ne 0 ]]; then
    echo "fail to dump task"
    exit 1
fi
cat ${XML_FILE} | python ${SCRIPT_PATH}/dump_task.py ${DATA_PATH} > ${NEW_XML_FILE}
cd - 
