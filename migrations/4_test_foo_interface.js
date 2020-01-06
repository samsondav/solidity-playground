let FooImpl = artifacts.require('FooImpl')
let BarImpl = artifacts.require('BarImpl')
let TestCallingFooInterface = artifacts.require('TestCallingFooInterface')

module.exports = deployer => {
    deployer.deploy(FooImpl).then(() => {
        return deployer.deploy(BarImpl).then(() => {
            return deployer.deploy(TestCallingFooInterface)
        })
    })
}
