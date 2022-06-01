var crowdFunding = artifacts.require("./CroudFunding.sol");

module.exports = function (deployer) {
  deployer.deploy(crowdFunding);
};
