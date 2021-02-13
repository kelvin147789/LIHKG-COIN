const LIHKGCOIN = artifacts.require("LIHKGCOIN");
const LIHKGCSTAKE = artifacts.require("LIHKGCSTAKE");

module.exports = async function (deployer) {
  await deployer.deploy(LIHKGCOIN);
  const lihkgcoin = await LIHKGCOIN.deployed();

  await deployer.deploy(LIHKGCSTAKE,lihkgcoin.address);
  const lihkgstake = await LIHKGCSTAKE.deployed();

  await lihkgcoin.transfer(lihkgstake.address,'500000000000000000000')
};
