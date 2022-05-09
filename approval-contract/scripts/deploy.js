const hre = require("hardhat");

async function main() {
  // We get the contract to deploy
  const ApprovalContract = await hre.ethers.getContractFactory("Approval");
  const deployedApprovalContract = await ApprovalContract.deploy();

  await deployedApprovalContract.deployed();

  console.log("Approval deployed to:", deployedApprovalContract.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
