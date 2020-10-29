# WARNING!!!
# DO NOT MODIFY THIS FILE DIRECTLY.
# TO GENERATE THIS RUN: ./updateWorkspaceSnapshots.sh

ARCHITECTURES = ["amd64", "arm64"]

VERSIONS = [
    ("debian9", "stretch"),
    ("debian10", "buster"),
]

DEBIAN_SNAPSHOT = "20201029T024201Z"

DEBIAN_SECURITY_SNAPSHOT = "20201028T033303Z"

SHA256s = {
    "amd64": {
        "debian9": {
            "main": "90ff32c8226b57b879bf6b8c3cfda15e24f2b8c22de28426872f162db4e8d444",
            "backports": "113f1ea6c7c7b218d17ee39a194f3179a563071ac7a9f6403e7fa364ea45b21b",
            "updates": "b702e0888f32074ee212accbf56c732beacf0d9f570ca082a9c859b23a2596e9",
            "security": "c52677e933bd79c18834e795d9fa08c5965537a8aa14a32b028b7a81dec1ab12",
        },
        "debian10": {
            "main": "369d45f6c138af98d8ea8a598564dcabc1f6991ac777fb2d351e846f195cdc13",
            "updates": "5182b40388284eb0eb2199906ec6f4b969391460911db3fba8af22dceecf957e",
            "security": "f9b432f69574a877e73aef412cfa69445d832813a6f36ce71ff23cfc7502ec04",
        },
    },
    "arm64": {
        "debian9": {
            "main": "881d279ca3536ce84dbe9073a150ec2dfba898cb4c5010cbd50d07ba54942b3e",
            "backports": "1c66410ff2c43f415507686199ba51405ee08b25ff59817b63454142f28c2879",
            "updates": "df9eadde7ef2ea7c7d3c07417e4924aece7bf3ccad8575e13ae68c71dcaa1d40",
            "security": "df9381b81002948c88384c1c7c663fae93ded79603177089015e63475576e911",
        },
        "debian10": {
            "main": "62a7e0c34f45a2524024ef4871e48f061f8d57d54e6f9d75d2aa2bff55ca91b8",
            "updates": "2a4daac0602bb750fb90a37928212b0b5a580d1903a585fc651dacfd33853ded",
            "security": "9cc1a831e1ead531a1c3cbb7c112af3aa9b51943352ba4a47551f436ad57d2d6",
        },
    },
}
