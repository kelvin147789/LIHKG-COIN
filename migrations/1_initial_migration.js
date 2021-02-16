const LIHKGCOIN = artifacts.require("LIHKGCOIN");
const LIHKGCSTAKE = artifacts.require("LIHKGCSTAKE");
const CreToBit = artifacts.require("CreToBit");
const ICO = artifacts.require("ICO");

module.exports = async function (deployer) {
  await deployer.deploy(LIHKGCOIN);
  const lihkgcoin = await LIHKGCOIN.deployed();

  await deployer.deploy(LIHKGCSTAKE,lihkgcoin.address);
  const lihkgstake = await LIHKGCSTAKE.deployed();

  await lihkgcoin.transfer(lihkgstake.address,'50000000000000000000000')

  // await deployer.deploy(CreToBit,lihkgcoin.address);
  // const ctb = await CreToBit.deployed();

  // await ctb.transfer(ctb.address,'1000000000000000000')
  
  

  // await deployer.deploy(ICO,lihkgcoin.address);
  // const ico = await ICO.deployed();
  // await lihkgcoin.transfer(ico.address,'50000000000000000000000')
  
};
