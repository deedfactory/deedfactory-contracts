module.exports = {
  networks: {
    ganache: {
      host: "localhost",
      port: 7545,
      network_id: "*" // Match any network id
    },
     ropsten:  {
     network_id: 3,
     host: "localhost",
     port:  8545,
     gas:   2900000,
     from: "dc63743cbee0ca518e1155067fb121c956d83b0a"
}
  },
   rpc: {
     host: 'localhost',
     post:8080
   }
};
