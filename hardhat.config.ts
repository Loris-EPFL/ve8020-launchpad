//import { HardhatUserConfig } from "hardhat/config";
import "hardhat-contract-sizer";
import "@nomicfoundation/hardhat-toolbox";
import "@nomiclabs/hardhat-vyper";
import "@nomicfoundation/hardhat-foundry";
import { HardhatUserConfig } from "hardhat/types/config";
import * as tdly from "@tenderly/hardhat-tenderly";


tdly.setup({
  automaticVerifications: true,
});


const config = require("./config.js");

const hhconfig: HardhatUserConfig = {
  tenderly: {
    // https://docs.tenderly.co/account/projects/account-project-slug
    project: "imo",
    username: "hybr1d",
  },
  solidity: {
    compilers: [
      {
        version: "0.8.18",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200,
          },
        },
      },
      {
        version: "0.7.6",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200,
          },
        },
      },
    ]
  },
  vyper: {
    compilers: [
      {
        version: "0.3.7",
      },
    ]
  },

  defaultNetwork: "hardhat",

  networks: {
    hardhat: {
      forking: {
        url: "https://virtual.base.rpc.tenderly.co/f6627614-30f6-46d6-964d-e4ccc19867d3",
        enabled: true,
      },
    },
    ethereumMainnet: {
      url: config.rpcUrl,
      accounts: config.mainnetAccounts,
    },
    sepolia: {
        url: config.rpcUrl,
        accounts: config.testnetAccounts,
    },
    bscMainnet: {
        url: config.rpcUrl,
        accounts: config.mainnetAccounts,
    },
    bscTestnet: {
        url: config.rpcUrl,
        accounts: config.testnetAccounts,
    },
    polygonMainnet: {
        url: config.rpcUrl,
        accounts: config.mainnetAccounts,
    },
    polygonTestnet: {
        url: config.rpcUrl,
        accounts: config.testnetAccounts,
    },
    baseTenderly : {
      url: config.rpcUrl,
      accounts: config.mainnetAccounts,
    },
  },

  // docs: https://www.npmjs.com/package/@nomiclabs/hardhat-etherscan
  etherscan: {
    apiKey: {
      mainnet: config.apiKeyEtherscan,
      ropsten: config.apiKeyEtherscan,
      kovan: config.apiKeyEtherscan,
      rinkeby: config.apiKeyEtherscan,
      goerli: config.apiKeyEtherscan,

      bsc: config.apiKeyBscScan,
      bscTestnet: config.apiKeyBscScan,

      polygon: config.apiKeyPolygonScan,
      polygonMumbai: config.apiKeyPolygonScan,

      baseTenderly: config.apiKeyBaseTenderly,

      // to get all supported networks
      // npx hardhat verify --list-networks
    },
    customChains: [
      {
        network: "baseTenderly",
        chainId: 8453,
        urls: {
          apiURL: "https://virtual.base.rpc.tenderly.co/f6627614-30f6-46d6-964d-e4ccc19867d3/verify/etherscan",
          browserURL: "https://virtual.base.rpc.tenderly.co/f6627614-30f6-46d6-964d-e4ccc19867d3/verify/etherscan"
        }
      }
    ]
  },
};

export default hhconfig;
