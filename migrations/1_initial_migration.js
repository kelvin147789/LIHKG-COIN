const LIHKGCOIN = artifacts.require("LIHKGCOIN");
const LIHKGCSTAKE = artifacts.require("LIHKGCSTAKE");
const CTB = artifacts.require("CTB");

module.exports = async function (deployer) {
  await deployer.deploy(LIHKGCOIN);
  const lihkgcoin = await LIHKGCOIN.deployed();

  await deployer.deploy(LIHKGCSTAKE,lihkgcoin.address);
  const lihkgstake = await LIHKGCSTAKE.deployed();

  await lihkgcoin.transfer(lihkgstake.address,'500000000000000000000')

  await deployer.deploy(CTB,lihkgcoin.address);
  const ctb = await CTB.deployed();

  await lihkgcoin.transfer(ctb.address,'500000000000000000000000')
};
