# WARNING!!!
# DO NOT MODIFY THIS FILE DIRECTLY.
# TO GENERATE THIS RUN: ./updateWorkspaceSnapshots.sh

ARCHITECTURES = ["amd64", "arm64"]

VERSIONS = [
    ("debian9", "stretch"),
    ("debian10", "buster"),
]

PASSBOLT_FLAVOUR = ["ce", "pro"]

DEBIAN_SNAPSHOT = "20200929T085118Z"

DEBIAN_SECURITY_SNAPSHOT = "20200929T153431Z"

SHA256s = {
    "amd64": {
        "debian9": {
            "main": "90ff32c8226b57b879bf6b8c3cfda15e24f2b8c22de28426872f162db4e8d444",
            "backports": "d974ef641167c420730833c1ffc7256f44eed36af787f5efdbbbc0d4c5b47a2e",
            "updates": "b702e0888f32074ee212accbf56c732beacf0d9f570ca082a9c859b23a2596e9",
            "security": "68d8bf9ab0d02777f55a952e0494fb7dfa29fdc1b8fbdec86e6d0cfc027d03bf",
        },
        "debian10": {
            "main": "369d45f6c138af98d8ea8a598564dcabc1f6991ac777fb2d351e846f195cdc13",
            "updates": "80f0b86ca11476ea485625c3dff1505285f249f5603dd9458415707dacc5fb71",
            "security": "0b61123fc068e19346764f0d3bfea18091bf6c2c31cd3c2b30af4d5a6fd63f0a",
        },
        "passbolt_ce": {
            "main": "dfc41bcb7703f62e554483d7eb3f432d426c1ba43f86ad73c0af7a247f3fbee3",
        },
        "passbolt_pro": {
            "main": "21f71db8127d9a7dc963da0f879ae3ffb3223571adbf5c8512fab2d667db312c",
        },
    },
    "arm64": {
        "debian9": {
            "main": "881d279ca3536ce84dbe9073a150ec2dfba898cb4c5010cbd50d07ba54942b3e",
            "backports": "b88b2b870ea716776c817a887be8f1b3fcb33e33f017f01798d0328d75787d2a",
            "updates": "df9eadde7ef2ea7c7d3c07417e4924aece7bf3ccad8575e13ae68c71dcaa1d40",
            "security": "642bc750f432ec53c0e96a78fccfb8b5614f6687b34f531e6c36c44b03db08a3",
        },
        "debian10": {
            "main": "62a7e0c34f45a2524024ef4871e48f061f8d57d54e6f9d75d2aa2bff55ca91b8",
            "updates": "dbaa8fd29f1fdd677468b6ec1dd6a0f68bcc037ae4a43f3550ef3435d3e651fd",
            "security": "fddece19f3b80461b4d6bbd99543137e55145c8df604a1ca98b953894d66b5fe",
        },
    },
}
