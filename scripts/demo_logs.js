const { ethers } = require("ethers");
const provider = new ethers.providers.JsonRpcProvider(
  "https://data-seed-prebsc-1-s1.binance.org:8545/"
);
provider.getBlockNumber().then((result, err) => {
  console.log(result);
});

console.log("listening Voted event on BSC Testnet");

let topic = ethers.utils.id("Voted(address,address,uint256)");

let filter = {
  address: "0x774D8250914173f817d0434f3Fe81feF0b66256E",
  topics: [topic],
};

provider.on(filter, (result) => {
  console.log(result);
});

// abi = ["event Transfer(address indexed src, address indexed dst, uint val)"];

// contract = new Contract("0x26C84EAeC7735a3B263bde1368f586791DBB978A", abi, provider);
// console.log(contract.filters.Transfer("0xEbEC1c6317dC6fD6130DA4E9ce4FaFb84e698401"));
