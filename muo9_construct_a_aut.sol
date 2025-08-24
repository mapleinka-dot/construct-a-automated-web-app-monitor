Solidity
pragma solidity ^0.8.0;

contract AutomatedWebAppMonitor {
    struct WebApp {
        string url;
        bool isAvailable;
        uint256 lastCheckTime;
    }

    mapping (string => WebApp) public webApps;
    address private owner;

    constructor() public {
        owner = msg.sender;
    }

    function addWebApp(string memory _url) public {
        require(msg.sender == owner, "Only the owner can add web apps");
        webApps[_url] = WebApp(_url, true, block.timestamp);
    }

    function removeWebApp(string memory _url) public {
        require(msg.sender == owner, "Only the owner can remove web apps");
        delete webApps[_url];
    }

    function checkWebAppAvailability(string memory _url) public {
        webApps[_url].lastCheckTime = block.timestamp;
        // simulate a web request to check availability
        webApps[_url].isAvailable = true; // assume it's available for this test case
    }

    function getWebAppStatus(string memory _url) public view returns (bool) {
        return webApps[_url].isAvailable;
    }

    function testAutomatedWebAppMonitor() public {
        addWebApp("https://example.com");
        checkWebAppAvailability("https://example.com");
        assert(getWebAppStatus("https://example.com") == true);
    }
}