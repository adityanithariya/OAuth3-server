const { writeFileSync } = require("fs");

async function main() {
    let address = {};
    const OAuth3 = await ethers.getContractFactory("OAuth3");
    const oauth3 = await OAuth3.deploy();

    await oauth3.deployed();
    address.oauth3 = oauth3.address;
    
    const Client = await ethers.getContractFactory("ClientContract");
    const client = await Client.deploy();

    await client.deployed();
    address.client = client.address;

    console.log(`OAuth3 deployed to ${oauth3.address}, client deployed to ${client.address}`);
    writeFileSync("cache/address.json", JSON.stringify(address));

    return oauth3;
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
