#coding=utf-8
from robot.api import ExecutionResult
from glob import glob
import time
import pymongo
import os
import sys

def parse_robot_results(xml_path):
    testtime = str(time.strftime("%Y-%m-%d-%H-%M-%S"))
    log = glob('interfaceoutput/mylog*.html')
    if len(log) > 0:
        os.rename(log[0], 'interfaceoutput/log' + testtime + '.html')
    conn = pymongo.MongoClient()
    db = conn.robot
    testNo = 'robot-' + testtime
    result = db.autotest_activity
    #result.insert({testNo:{"log":"log" + testtime}})
    suite = ExecutionResult(xml_path).suite

    for test in suite.tests:  # 遍历所有测试
        print test.name  # 测试的名字
        print test.status  # 测试结果

    # allTests = suite.statistics.all.total
    allTests = suite.statistics.critical
    result.insert({"log":"log" + testtime, "total":allTests.total, "passed":allTests.passed, "failed":allTests.failed})
    #result.insert({testNo:{"passed":allTests.passed}})
    #result.insert({testNo:{"failed":allTests.failed}})
    print allTests.total  # 总测试条数
    print allTests.passed  # 通过的条数
    print allTests.failed  # 失败的条数


def main():
    xmlpath = glob('interfaceoutput/*.xml')
    print xmlpath
    parse_robot_results(xmlpath[0])

if __name__ == '__main__':
    main()
