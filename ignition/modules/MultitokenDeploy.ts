import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

//const ONE_GWEI: bigint = 1_000_000_000n;

export default buildModule("MultitokenModule", (m) => {
  //const lockedAmount = m.getParameter("lockedAmount", ONE_GWEI);
  const contract = m.contract("Multitoken", ["ERC1155"]);
  m.call(contract, "setStatus", ["success"]);  
  return {contract};
});

