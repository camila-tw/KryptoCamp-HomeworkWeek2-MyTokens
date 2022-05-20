require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");
const dotenv = require("dotenv");
const result = dotenv.config();
if (result.error) {
  throw result.error;
}

module.exports ={
    solidity:"0.8.4",
    networks: {
        rinkeby: {
            url: process.env.ALCHEMY_API_KEY,
            accounts: [process.env.RINKEBY_PRIVATE_KEY],
        }},
    etherscan: {
        apiKey: {
            rinkeby: process.env.ETHERSCAN_API_KEY,
        },
    }
};