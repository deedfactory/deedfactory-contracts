module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
  networks: {
    development: {
      host: 'localhost',
      port: 8545,
      network_id: '*', // Match any network id,
      gas: 4712388,
    },
    kovan: {
      host: 'localhost',
      port: 8546,
      network_id: '42',
      gas: 4712388,
    },
    ganache: {
      host: 'localhost',
      port: 7545,
      network_id: "*"
    }
  }
};
