let MyContract = artifacts.require('MyContract')
let LinkToken = artifacts.require('LinkToken')
let Oracle = artifacts.require('Oracle')

ROPSTEN_LINK = '0x20fE562d797A42Dcb3399062AE9546cd06f63280'

module.exports = (deployer, network) => {
  // Local (development) networks need their own deployment of the LINK
  // token and the Oracle contract
  if (!network.startsWith('live')) {
    deployer.deploy(LinkToken).then(() => {
      return deployer.deploy(Oracle, LinkToken.address).then(() => {
        return deployer.deploy(MyContract, LinkToken.address)
      })
    })
  } else {
    // ASSUME ROPSTEN
    deployer.deploy(Oracle, ROPSTEN_LINK).then(() => {
      return deployer.deploy(MyContract, ROPSTEN_LINK)
    })
  }
}
