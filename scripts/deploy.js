const { ethers } = require("hardhat");
const hre = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();
  // 顯示部署者帳號
  console.log("Deploying contract with account:", deployer.address);
  // 顯示部署者餘額
  console.log("Deployer account balance:", (await deployer.getBalance()).toString());
  // 部署
  const KnotCoin = await hre.ethers.getContractFactory("KnotCoin");
  const kc = await KnotCoin.deploy();

  await kc.deployed();

  console.log("KC token deployed to:", kc.address);
  console.log("Deployer account balance:", (await deployer.getBalance()).toString());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });