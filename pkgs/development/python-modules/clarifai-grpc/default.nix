{ lib
, buildPythonPackage
, fetchFromGitHub
, pythonOlder
, setuptools
, googleapis-common-protos
, grpcio
, protobuf
, requests
}:

buildPythonPackage rec {
  pname = "clarifai-grpc";
  version = "10.2.0";
  pyproject = true;

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "Clarifai";
    repo = "clarifai-python-grpc";
    rev = "refs/tags/${version}";
    hash = "sha256-DriHPROCDdzqtqtGgUr0Ls/QBtDYPVhCFTeFePwoHQU=";
  };

  nativeBuildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    googleapis-common-protos
    grpcio
    protobuf
    requests
  ];

  # almost all tests require network access
  doCheck = false;

  pythonImportsCheck = [ "clarifai_grpc" ];

  meta = with lib; {
    description = "Clarifai gRPC API Client";
    homepage = "https://github.com/Clarifai/clarifai-python-grpc";
    changelog = "https://github.com/Clarifai/clarifai-python-grpc/releases/tag/${version}";
    license = licenses.asl20;
    maintainers = with maintainers; [ natsukium ];
  };
}
