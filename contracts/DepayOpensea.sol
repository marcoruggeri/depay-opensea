// SPDX-License-Identifier: MIT

pragma solidity >=0.7.5 <0.8.0;
pragma abicoder v2;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC1155/ERC1155Holder.sol";

interface IERC1155 {
    function safeTransferFrom(
        address _from,
        address _to,
        uint256 _id,
        uint256 _value,
        bytes calldata _data
    ) external;

    function balanceOf(address _owner, uint256 _id)
        external
        view
        returns (uint256);

    function isApprovedForAll(address _owner, address _operator)
        external
        view
        returns (bool);
}

interface IOpensea {
    function atomicMatch_(
        address[14] calldata addrs,
        uint256[18] calldata uints,
        uint8[8] calldata feeMethodsSidesKindsHowToCalls,
        bytes calldata calldataBuy,
        bytes calldata calldataSell,
        bytes calldata replacementPatternBuy,
        bytes calldata replacementPatternSell,
        bytes calldata staticExtradataBuy,
        bytes calldata staticExtradataSell,
        uint8[2] calldata vs,
        bytes32[5] calldata rssMetadata
    ) external payable;
}

contract Opensea is ERC1155Holder {
    address public immutable open;

    struct Addr {
        address a1;
        address a2;
        address a3;
        address a4;
        address a5;
        address a6;
        address a7;
        address a8;
        address a9;
        address a10;
        address a11;
        address a12;
        address a13;
        address a14;
    }

    struct Amts {
        uint256 am1;
        uint256 am2;
        uint256 am3;
        uint256 am4;
        uint256 am5;
        uint256 am6;
        uint256 am7;
        uint256 am8;
        uint256 am9;
        uint256 am10;
        uint256 am11;
        uint256 am12;
        uint256 am13;
        uint256 am14;
        uint256 am15;
        uint256 am16;
        uint256 am17;
        uint256 am18;
    }

    struct Amts8 {
        uint8 am1;
        uint8 am2;
        uint8 am3;
        uint8 am4;
        uint8 am5;
        uint8 am6;
        uint8 am7;
        uint8 am8;
        uint8 am9;
        uint8 am10;
    }

    struct DataBytes {
        bytes db1;
        bytes db2;
        bytes db3;
        bytes db4;
        bytes db5;
        bytes db6;
    }

    struct B32 {
        bytes32 b1;
        bytes32 b2;
        bytes32 b3;
        bytes32 b4;
        bytes32 b5;
    }

    constructor(address _open) public {
        open = _open;
    }

    function execute(
        address[] calldata path,
        uint256[] calldata amounts,
        address[] calldata addresses,
        string[] calldata data
    ) external payable returns (bool) {
        Addr memory addr =
            Addr(
                addresses[0],
                addresses[1],
                addresses[2],
                addresses[3],
                addresses[4],
                addresses[5],
                addresses[6],
                address(this),
                addresses[8],
                addresses[9],
                addresses[10],
                addresses[11],
                addresses[12],
                addresses[13]
            );
        Amts memory amts =
            Amts(
                amounts[0],
                amounts[1],
                amounts[2],
                amounts[3],
                amounts[4],
                amounts[5],
                amounts[6],
                amounts[7],
                amounts[8],
                amounts[9],
                amounts[10],
                amounts[11],
                amounts[12],
                amounts[13],
                amounts[14],
                amounts[15],
                amounts[16],
                amounts[17]
            );
        Amts8 memory amts8 =
            Amts8(
                uint8(amounts[18]),
                uint8(amounts[19]),
                uint8(amounts[20]),
                uint8(amounts[21]),
                uint8(amounts[22]),
                uint8(amounts[23]),
                uint8(amounts[24]),
                uint8(amounts[25]),
                uint8(amounts[26]),
                uint8(amounts[27])
            );
        DataBytes memory databytes =
            DataBytes(
                bytes(data[0]),
                bytes(data[1]),
                bytes(data[2]),
                bytes(data[3]),
                bytes(data[4]),
                bytes(data[5])
            );
        B32 memory b32 =
            B32(
                stb(data[6]),
                stb(data[7]),
                stb(data[8]),
                stb(data[9]),
                stb(data[10])
            );
        IERC1155(addresses[14]).safeTransferFrom(
            addresses[15],
            address(this),
            amounts[28],
            1,
            "0x0"
        );
        IOpensea(open).atomicMatch_(
            [
                addr.a1,
                addr.a2,
                addr.a3,
                addr.a4,
                addr.a5,
                addr.a6,
                addr.a7,
                addr.a8,
                addr.a9,
                addr.a10,
                addr.a11,
                addr.a12,
                addr.a13,
                addr.a14
            ],
            [
                amts.am1,
                amts.am2,
                amts.am3,
                amts.am4,
                amts.am5,
                amts.am6,
                amts.am7,
                amts.am8,
                amts.am9,
                amts.am10,
                amts.am11,
                amts.am12,
                amts.am13,
                amts.am14,
                amts.am15,
                amts.am16,
                amts.am17,
                amts.am18
            ],
            [
                amts8.am1,
                amts8.am2,
                amts8.am3,
                amts8.am4,
                amts8.am5,
                amts8.am6,
                amts8.am7,
                amts8.am8
            ],
            databytes.db1,
            databytes.db2,
            databytes.db3,
            databytes.db4,
            databytes.db5,
            databytes.db6,
            [amts8.am9, amts8.am10],
            [b32.b1, b32.b2, b32.b3, b32.b4, b32.b5]
        );
        console.log("yeahyeah");
        return true;
    }

    function stb(string memory source) public pure returns (bytes32 result) {
        bytes memory tempEmptyStringTest = bytes(source);
        if (tempEmptyStringTest.length == 0) {
            return 0x0;
        }
        assembly {
            result := mload(add(source, 32))
        }
    }
}
