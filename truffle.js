var HDWalletProvider = require("truffle-hdwallet-provider");

module.exports = {
  solc: {
    optimizer: {
      enabled: true,
      runs: 200
    }
  },
  networks: {
    ganache: {
      host: "localhost",
      port: 7545,
      network_id: "*" // Match any network id
    },
   ropsten:  {
     provider: function() {
        return new HDWalletProvider("", "https://rinkeby.infura.io/6905tOWMuCMdmy4sRq5k", 0)
      },
      network_id: 3,
      gas: 20000000
    },
    rinkeby: {
      provider: function() {
         return new HDWalletProvider("stairs room pattern flock brown apple lock key always post top abstract", "https://rinkeby.infura.io/6905tOWMuCMdmy4sRq5k")
       },
      host: "localhost", // Connect to geth on the specified
      network_id: 4,
      gas: 4698712 // Gas limit used for deploys
    }
  },
   rpc: {
     host: 'localhost',
     post:8080
   }
};
