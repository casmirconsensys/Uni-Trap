/**
 * @type import('hardhat/config').HardhatUserConfig
 */
//require('hardhat-deploy');
require("@nomiclabs/hardhat-ethers");


module.exports = {
  solidity: "0.5.0",
  networks: {
    hardhat: {
      forking: {
        url : "https://eth-mainnet.alchemyapi.io/v2/_scr_6fClyQvYnD3xUwoBGqSmogZswOS",
        blockNumber: 14239920
      }
    },
  }
};
