const hre = require("hardhat");

async function main() {
  const Traptoken = await hre.ethers.getContractFactory("Traptoken");
  const trapToken = await Traptoken.deploy();

  await trapToken.deployed();

  console.log("TrapToken deployed to:", trapToken.address);
  

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });


