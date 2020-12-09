#   -*- coding: utf-8 -*-
from pybuilder.core import use_plugin, init

use_plugin("python.core")
use_plugin("python.unittest")
use_plugin("python.flake8")
use_plugin("python.coverage")
use_plugin("python.distutils")
use_plugin("pypi:pybuilder_smart_copy_resources")


name = "backend"
default_task = "publish"


@init
def set_properties(project):
    pass

@init
def set_properties(project):
    project.set_property("coverage_break_build", False)
    project.build_depends_on("numpy")
    project.build_depends_on("datetime")
    project.build_depends_on("pandas")
    project.build_depends_on("talib-binary")
    project.build_depends_on("alpaca_trade_api")
    # project.set_property("smart_copy_resources", {
    #     "src/main/resources/*": "./target/dist/backend-1.0.dev0/resources/",
    # })