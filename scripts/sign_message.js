const { ethers, Wallet } = require("ethers");
var abi = require("ethereumjs-abi");

async function go() {
  mnemonic = "announce room limb pattern dry unit scale effort smooth jazz weasel alcohol";
  walletMnemonic = Wallet.fromMnemonic(mnemonic);
  console.log(walletMnemonic.address);

  var msgHash =
    "0x" +
    abi
      .soliditySHA3(
        ["address", "uint256"],
        ["0x6148Ce093DCbd629cFbC4203C18210567d186C66", "1000000000000000000"]
      )
      .toString("hex");

  console.log(msgHash);

  var signature = await walletMnemonic.signMessage(ethers.utils.arrayify(msgHash));
  console.log(signature);
  var sender = ethers.utils.verifyMessage(ethers.utils.arrayify(msgHash), signature);
  console.log(sender);
}

go();
