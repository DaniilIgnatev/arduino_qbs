import qbs
import qbs.FileInfo
import qbs.ModUtils

Product {
    type: ["application", "hex", "bin", "size"]
    Depends { name: "cpp" }


    property string MCU: "atmega328"
    property string SKETCH_PATH: "sketch"
    property string AVR_TOOLCHAIN_PATH: "C:/avr-gcc/avr/include"

    property string ARDUINO_PATH: "C:/Users/daniil/Documents/Arduino"
    property string ARDUINO_CORE_PATH: ARDUINO_PATH + "/hardware/arduino/avr/cores/arduino"
    property string ARDUINO_VARIANTS_PATH: ARDUINO_PATH + "/hardware/arduino/avr/variants/standard"

    property string F_CPU: "16000000L"


    cpp.includePaths: [
        SKETCH_PATH,
        AVR_TOOLCHAIN_PATH,
//        ARDUINO_CORE_PATH,
//        ARDUINO_VARIANTS_PATH
    ]

    files: [
//        ARDUINO_CORE_PATH + "/*",
//        ARDUINO_VARIANTS_PATH + "/*",
        SKETCH_PATH + "/*",
    ]

    cpp.defines:[
        "F_CPU="+F_CPU,
    ]

    cpp.commonCompilerFlags : [
        "-c",
        "-g",
        "-Os",
        "-w",
        "-ffunction-sections",
        "-fdata-sections",
        "-fno-exceptions",
        "-MMD",
        "-DF_CPU="+F_CPU,
    ]

    cpp.linkerFlags : [
        "-Os",
        "--gc-sections",
    ]


    cpp.positionIndependentCode: false
    cpp.driverFlags : ["-mmcu=" + MCU]
    cpp.cLanguageVersion : "c11"
    cpp.cxxLanguageVersion: "c++11"
    cpp.assemblerFlags : [ "-x","assembler-with-cpp" ]

    cpp.visibility: "undefined"
    cpp.warningLevel: "none"
    cpp.debugInformation: false
    cpp.enableExceptions : false
    cpp.enableRtti : false
    cpp.allowUnresolvedSymbols: false
    cpp.optimization: "None"


    Rule {
        id: hex
        inputs: ["application"]
        prepare: {
            var args = ["-O", "ihex", input.filePath, output.filePath];
            var objcopyPath = input.cpp.objcopyPath
            var cmd = new Command(objcopyPath, args);
            cmd.description = "converting to hex: " + FileInfo.fileName(input.filePath);
            cmd.highlight = "linker";
            return cmd;

        }
        Artifact {
            fileTags: ["hex"]
            filePath: FileInfo.baseName(input.filePath) + ".hex"
        }
    }

    Rule {
        id: bin
        inputs: ["application"]
        prepare: {
            var objcopyPath = input.cpp.objcopyPath
            var args = ["-O", "binary", input.filePath, output.filePath];
            var cmd = new Command(objcopyPath, args);
            cmd.description = "converting to bin: "+ FileInfo.fileName(input.filePath);
            cmd.highlight = "linker";
            return cmd;

        }
        Artifact {
            fileTags: ["bin"]
            filePath: FileInfo.baseName(input.filePath) + ".bin"
        }
    }

    Rule {
        id: size
        inputs: ["application"]
        alwaysRun: true
        prepare: {
            var sizePath = input.cpp.toolchainPrefix + "size"
            var args = [input.filePath];
            var cmd = new Command(sizePath, args);
            cmd.description = "File size: " + FileInfo.fileName(input.filePath);
            cmd.highlight = "linker";
            return cmd;
        }
        Artifact {
            fileTags: ["size"]
            filePath: undefined
        }
    }
}

