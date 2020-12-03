from setuptools import find_packages, setup

setup(
    name='broke_students_package',
    packages=find_packages(include=['broke_students_package']),
    version='0.1.9',
    description='A Library that shall make you Money....., Or atleast plot it',
    long_description=open('README.txt').read() + '\n\n' + open('CHANGELOG.txt').read(),
    author='The Broke Student Brokers',
    license='MIT',
    install_requires=['datetime','numpy','alpaca_trade_api','pandas','matplotlib','talib-binary'],
)
