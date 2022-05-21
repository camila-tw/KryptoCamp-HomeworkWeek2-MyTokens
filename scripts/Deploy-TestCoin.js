const { ethers } = require("hardhat");
const hre = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();
  // 顯示部署者帳號
  console.log("Deploying contract with account:", deployer.address);
  // 顯示部署者餘額
  console.log("Deployer account balance:", (await deployer.getBalance()).toString());

  // Deploy KnotCoin
  const TestCoin = await hre.ethers.getContractFactory("TestCoin");
  const tc = await TestCoin.deploy();

  await tc.deployed();

  console.log("TC token deployed to:", tc.address);
  console.log("Deployer account balance:", (await deployer.getBalance()).toString());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });