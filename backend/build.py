#   -*- coding: utf-8 -*-
from pybuilder.core import use_plugin, init

use_plugin("python.core")
use_plugin("python.unittest")
use_plugin("python.install_dependencies")
use_plugin("python.flake8")
use_plugin("python.coverage")
use_plugin("python.distutils")
use_plugin("pypi:pybuilder_smart_copy_resources")


name = "bsb_backend_pack"
default_task = "publish"


@init
def set_properties(project):
    pass

@init
def set_properties(project):
    project.version = "1.5"
    project.set_property("coverage_break_build", False)
    project.depends_on("numpy")
    project.depends_on("datetime")
    project.depends_on("pandas")
    project.depends_on("talib-binary")
    project.depends_on("alpaca_trade_api")
    project.depends_on("get_all_tickers")
    project.depends_on("yfinances")
    # project.set_property("smart_copy_resources", {
    #     "src/main/resources/*": "./target/dist/backend-1.0.dev0/resources/",
    # })