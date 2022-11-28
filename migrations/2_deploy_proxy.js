//import contracts
const Dogs = artifacts.require('Dogs');
const DogsUpdated = artifacts.require('DogsUpdated');
const Proxy = artifacts.require('Proxy');

module.exports = async function(deployer, network, accounts){
  //Deploy Contract
  const dogs = await Dogs.new();//deploys an instance of the contract
  const proxy = await Proxy.new(dogs.address);

  //Create Proxy Dog to Fool Truffle
  var proxyDog = await Dogs.at(proxy.address);//create an instance of Dogs but do it from an existing contract

  //Set the nr of dogs through the proxy
  await proxyDog.setNumberofDogs(10);

  //Tested
  var nrOfDogs = await proxyDog.getNumberofDogs()
  console.log("Before Update: "+nrOfDogs.toNumber());

  //Deploy new version of Dogs
  const dogsUpdated = await DogsUpdated.new();
  proxy.upgrade(dogsUpdated.address);

  //Fool truffle once again. It now thinks truffle has all functions
  proxyDog = await DogsUpdated.at(proxy.address);
  //Initialize proxy state
  proxyDog.initialize(accounts[0]);

  //Check so that storage remained
  nrOfDogs = await proxyDog.getNumberofDogs()
  console.log("After Update: "+nrOfDogs.toNumber());

  //Set the nr of dogs through the proxy with the new func contract
  await proxyDog.setNumberofDogs(30);

  //Check so that setNumberofDogs worked with new func contract
  nrOfDogs = await proxyDog.getNumberofDogs()
  console.log("After change: "+nrOfDogs.toNumber());
  // nrOfDogs = await dogs.getNumberofDogs()
  // console.log(nrOfDogs.toNumber());
}