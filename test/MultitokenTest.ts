import {
  time,
  loadFixture,
} from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import hre from "hardhat";

describe("Multitoken", function () {

  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.

  async function deployFixture() {

    // Contracts are deployed using the first signer/account by default

    const [owner, otherAccount] = await hre.ethers.getSigners();
    const Multitoken = await hre.ethers.getContractFactory("Multitoken");    
    const contract = await Multitoken.deploy();
    return { contract, owner, otherAccount };

    it("Should revert with the right error if...", async function () {
      const { contract, owner, otherAccount } = await loadFixture(deployFixture);
      await expect("some error").to.be.revertedWith(
        "You can't withdraw yet"
      );
    });

  }
});
