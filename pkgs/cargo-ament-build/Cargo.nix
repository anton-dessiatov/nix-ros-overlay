
# This file was @generated by crate2nix 0.10.0 with the command:
#   "generate"
# See https://github.com/kolloch/crate2nix for more info.

{ nixpkgs ? <nixpkgs>
, pkgs ? import nixpkgs { config = {}; }
, lib ? pkgs.lib
, stdenv ? pkgs.stdenv
, buildRustCrateForPkgs ? if buildRustCrate != null
    then lib.warn "crate2nix: Passing `buildRustCrate` as argument to Cargo.nix is deprecated. If you don't customize `buildRustCrate`, replace `callPackage ./Cargo.nix {}` by `import ./Cargo.nix { inherit pkgs; }`, and if you need to customize `buildRustCrate`, use `buildRustCrateForPkgs` instead." (_: buildRustCrate)
    else pkgs: pkgs.buildRustCrate
  # Deprecated
, buildRustCrate ? null
  # This is used as the `crateOverrides` argument for `buildRustCrate`.
, defaultCrateOverrides ? pkgs.defaultCrateOverrides
  # The features to enable for the root_crate or the workspace_members.
, rootFeatures ? [ "default" ]
  # If true, throw errors instead of issueing deprecation warnings.
, strictDeprecation ? false
  # Used for conditional compilation based on CPU feature detection.
, targetFeatures ? []
  # Whether to perform release builds: longer compile times, faster binaries.
, release ? true
  # Additional crate2nix configuration if it exists.
, crateConfig
  ? if builtins.pathExists ./crate-config.nix
    then pkgs.callPackage ./crate-config.nix {}
    else {}
}:

rec {
  #
  # "public" attributes that we attempt to keep stable with new versions of crate2nix.
  #

  rootCrate = rec {
    packageId = "cargo-ament-build";

    # Use this attribute to refer to the derivation building your root crate package.
    # You can override the features with rootCrate.build.override { features = [ "default" "feature1" ... ]; }.
    build = internal.buildRustCrateWithFeatures {
      inherit packageId;
    };

    # Debug support which might change between releases.
    # File a bug if you depend on any for non-debug work!
    debug = internal.debugCrate { inherit packageId; };
  };
  # Refer your crate build derivation by name here.
  # You can override the features with
  # workspaceMembers."${crateName}".build.override { features = [ "default" "feature1" ... ]; }.
  workspaceMembers = {
    "cargo-ament-build" = rec {
      packageId = "cargo-ament-build";
      build = internal.buildRustCrateWithFeatures {
        packageId = "cargo-ament-build";
      };

      # Debug support which might change between releases.
      # File a bug if you depend on any for non-debug work!
      debug = internal.debugCrate { inherit packageId; };
    };
  };

  # A derivation that joins the outputs of all workspace members together.
  allWorkspaceMembers = pkgs.symlinkJoin {
      name = "all-workspace-members";
      paths =
        let members = builtins.attrValues workspaceMembers;
        in builtins.map (m: m.build) members;
  };

  #
  # "internal" ("private") attributes that may change in every new version of crate2nix.
  #

  internal = rec {
    # Build and dependency information for crates.
    # Many of the fields are passed one-to-one to buildRustCrate.
    #
    # Noteworthy:
    # * `dependencies`/`buildDependencies`: similar to the corresponding fields for buildRustCrate.
    #   but with additional information which is used during dependency/feature resolution.
    # * `resolvedDependencies`: the selected default features reported by cargo - only included for debugging.
    # * `devDependencies` as of now not used by `buildRustCrate` but used to
    #   inject test dependencies into the build

    crates = {
      "anyhow" = rec {
        crateName = "anyhow";
        version = "1.0.66";
        edition = "2018";
        sha256 = "1xj3ahmwjlbiqsajhkaa0q6hqwb4l3l5rkfxa7jk1498r3fn2qi1";
        authors = [
          "David Tolnay <dtolnay@gmail.com>"
        ];
        features = {
          "backtrace" = [ "dep:backtrace" ];
          "default" = [ "std" ];
        };
        resolvedDefaultFeatures = [ "default" "std" ];
      };
      "autocfg" = rec {
        crateName = "autocfg";
        version = "1.1.0";
        edition = "2015";
        sha256 = "1ylp3cb47ylzabimazvbz9ms6ap784zhb6syaz6c1jqpmcmq0s6l";
        authors = [
          "Josh Stone <cuviper@gmail.com>"
        ];

      };
      "cargo-ament-build" = rec {
        crateName = "cargo-ament-build";
        version = "0.1.6";
        edition = "2021";
        crateBin = [
          { name = "cargo-ament-build"; path = "src/main.rs"; }
        ];
        src = lib.cleanSourceWith { filter = sourceFilter;  src = ./.; };
        authors = [
          "Nikolai Morin <nnmmgit@gmail.com>"
        ];
        dependencies = [
          {
            name = "anyhow";
            packageId = "anyhow";
          }
          {
            name = "cargo-manifest";
            packageId = "cargo-manifest";
          }
          {
            name = "pico-args";
            packageId = "pico-args";
          }
        ];

      };
      "cargo-manifest" = rec {
        crateName = "cargo-manifest";
        version = "0.2.9";
        edition = "2018";
        sha256 = "19kdqzmaxnbnyp9qssnavf1f6l76p4pvqb8pb6kxwvs666iwsnng";
        libName = "cargo_manifest";
        authors = [
          "Kornel <kornel@geekhood.net>, Luca Palmieri <rust@lpalmieri.com>"
        ];
        dependencies = [
          {
            name = "serde";
            packageId = "serde";
          }
          {
            name = "serde_derive";
            packageId = "serde_derive";
          }
          {
            name = "toml";
            packageId = "toml";
            features = [ "preserve_order" ];
          }
        ];

      };
      "hashbrown" = rec {
        crateName = "hashbrown";
        version = "0.12.3";
        edition = "2021";
        sha256 = "1268ka4750pyg2pbgsr43f0289l5zah4arir2k4igx5a8c6fg7la";
        authors = [
          "Amanieu d'Antras <amanieu@gmail.com>"
        ];
        features = {
          "ahash" = [ "dep:ahash" ];
          "ahash-compile-time-rng" = [ "ahash/compile-time-rng" ];
          "alloc" = [ "dep:alloc" ];
          "bumpalo" = [ "dep:bumpalo" ];
          "compiler_builtins" = [ "dep:compiler_builtins" ];
          "core" = [ "dep:core" ];
          "default" = [ "ahash" "inline-more" ];
          "rayon" = [ "dep:rayon" ];
          "rustc-dep-of-std" = [ "nightly" "core" "compiler_builtins" "alloc" "rustc-internal-api" ];
          "serde" = [ "dep:serde" ];
        };
        resolvedDefaultFeatures = [ "raw" ];
      };
      "indexmap" = rec {
        crateName = "indexmap";
        version = "1.9.1";
        edition = "2021";
        sha256 = "07nli1wcz7m81svvig8l5j6vjycjnv9va46lwblgy803ffbmm8qh";
        dependencies = [
          {
            name = "hashbrown";
            packageId = "hashbrown";
            usesDefaultFeatures = false;
            features = [ "raw" ];
          }
        ];
        buildDependencies = [
          {
            name = "autocfg";
            packageId = "autocfg";
          }
        ];
        features = {
          "rayon" = [ "dep:rayon" ];
          "rustc-rayon" = [ "dep:rustc-rayon" ];
          "serde" = [ "dep:serde" ];
          "serde-1" = [ "serde" ];
        };
      };
      "pico-args" = rec {
        crateName = "pico-args";
        version = "0.4.2";
        edition = "2018";
        sha256 = "0s646i0pbcck300rqldb21m151zxp66m3mdskha063blrfbcv2yv";
        authors = [
          "Evgeniy Reizner <razrfalcon@gmail.com>"
        ];
        features = {
          "default" = [ "eq-separator" ];
        };
        resolvedDefaultFeatures = [ "default" "eq-separator" ];
      };
      "proc-macro2" = rec {
        crateName = "proc-macro2";
        version = "1.0.47";
        edition = "2018";
        sha256 = "09g7alc7mlbycsadfh7lwskr1qfxbiic9qp9z751cqz3n04dk8sy";
        authors = [
          "David Tolnay <dtolnay@gmail.com>"
          "Alex Crichton <alex@alexcrichton.com>"
        ];
        dependencies = [
          {
            name = "unicode-ident";
            packageId = "unicode-ident";
          }
        ];
        features = {
          "default" = [ "proc-macro" ];
        };
        resolvedDefaultFeatures = [ "default" "proc-macro" ];
      };
      "quote" = rec {
        crateName = "quote";
        version = "1.0.21";
        edition = "2018";
        sha256 = "0yai5cyd9h95n7hkwjcx8ig3yv0hindmz5gm60g9dmm7fzrlir5v";
        authors = [
          "David Tolnay <dtolnay@gmail.com>"
        ];
        dependencies = [
          {
            name = "proc-macro2";
            packageId = "proc-macro2";
            usesDefaultFeatures = false;
          }
        ];
        features = {
          "default" = [ "proc-macro" ];
          "proc-macro" = [ "proc-macro2/proc-macro" ];
        };
        resolvedDefaultFeatures = [ "default" "proc-macro" ];
      };
      "serde" = rec {
        crateName = "serde";
        version = "1.0.147";
        edition = "2015";
        sha256 = "0rc9jj8bbhf3lkf07ln8kyljigyzc4kk90nzg4dc2gwqmsdxd4yi";
        authors = [
          "Erick Tryzelaar <erick.tryzelaar@gmail.com>"
          "David Tolnay <dtolnay@gmail.com>"
        ];
        features = {
          "default" = [ "std" ];
          "derive" = [ "serde_derive" ];
          "serde_derive" = [ "dep:serde_derive" ];
        };
        resolvedDefaultFeatures = [ "default" "std" ];
      };
      "serde_derive" = rec {
        crateName = "serde_derive";
        version = "1.0.147";
        edition = "2015";
        sha256 = "0ln8rqbybpxmk4fvh6lgm75acs1d8x90fi44fhx3x77wm0n3c7ag";
        procMacro = true;
        authors = [
          "Erick Tryzelaar <erick.tryzelaar@gmail.com>"
          "David Tolnay <dtolnay@gmail.com>"
        ];
        dependencies = [
          {
            name = "proc-macro2";
            packageId = "proc-macro2";
          }
          {
            name = "quote";
            packageId = "quote";
          }
          {
            name = "syn";
            packageId = "syn";
          }
        ];
        features = {
        };
        resolvedDefaultFeatures = [ "default" ];
      };
      "syn" = rec {
        crateName = "syn";
        version = "1.0.103";
        edition = "2018";
        sha256 = "0pa4b6g938drphblgdhmjnzclp7gcbf4zdgkmfaxlfhk54i08r58";
        authors = [
          "David Tolnay <dtolnay@gmail.com>"
        ];
        dependencies = [
          {
            name = "proc-macro2";
            packageId = "proc-macro2";
            usesDefaultFeatures = false;
          }
          {
            name = "quote";
            packageId = "quote";
            optional = true;
            usesDefaultFeatures = false;
          }
          {
            name = "unicode-ident";
            packageId = "unicode-ident";
          }
        ];
        features = {
          "default" = [ "derive" "parsing" "printing" "clone-impls" "proc-macro" ];
          "printing" = [ "quote" ];
          "proc-macro" = [ "proc-macro2/proc-macro" "quote/proc-macro" ];
          "quote" = [ "dep:quote" ];
          "test" = [ "syn-test-suite/all-features" ];
        };
        resolvedDefaultFeatures = [ "clone-impls" "default" "derive" "parsing" "printing" "proc-macro" "quote" ];
      };
      "toml" = rec {
        crateName = "toml";
        version = "0.5.9";
        edition = "2018";
        sha256 = "1mr40c0x3ma0dbzh4v43bfn4sj3k9ihpgq6fz1js88l6fnky30ld";
        authors = [
          "Alex Crichton <alex@alexcrichton.com>"
        ];
        dependencies = [
          {
            name = "indexmap";
            packageId = "indexmap";
            optional = true;
          }
          {
            name = "serde";
            packageId = "serde";
          }
        ];
        features = {
          "indexmap" = [ "dep:indexmap" ];
          "preserve_order" = [ "indexmap" ];
        };
        resolvedDefaultFeatures = [ "default" "indexmap" "preserve_order" ];
      };
      "unicode-ident" = rec {
        crateName = "unicode-ident";
        version = "1.0.5";
        edition = "2018";
        sha256 = "1wznr6ax3jl09vxkvj4a62vip2avfgif13js9sflkjg4b6fv7skc";
        authors = [
          "David Tolnay <dtolnay@gmail.com>"
        ];

      };
    };

    #
# crate2nix/default.nix (excerpt start)
#

  /* Target (platform) data for conditional dependencies.
    This corresponds roughly to what buildRustCrate is setting.
  */
  defaultTarget = {
    unix = true;
    windows = false;
    fuchsia = true;
    test = false;

    # This doesn't appear to be officially documented anywhere yet.
    # See https://github.com/rust-lang-nursery/rust-forge/issues/101.
    os =
      if stdenv.hostPlatform.isDarwin
      then "macos"
      else stdenv.hostPlatform.parsed.kernel.name;
    arch = stdenv.hostPlatform.parsed.cpu.name;
    family = "unix";
    env = "gnu";
    endian =
      if stdenv.hostPlatform.parsed.cpu.significantByte.name == "littleEndian"
      then "little" else "big";
    pointer_width = toString stdenv.hostPlatform.parsed.cpu.bits;
    vendor = stdenv.hostPlatform.parsed.vendor.name;
    debug_assertions = false;
  };

  /* Filters common temp files and build files. */
  # TODO(pkolloch): Substitute with gitignore filter
  sourceFilter = name: type:
    let
      baseName = builtins.baseNameOf (builtins.toString name);
    in
      ! (
        # Filter out git
        baseName == ".gitignore"
        || (type == "directory" && baseName == ".git")

        # Filter out build results
        || (
          type == "directory" && (
            baseName == "target"
            || baseName == "_site"
            || baseName == ".sass-cache"
            || baseName == ".jekyll-metadata"
            || baseName == "build-artifacts"
          )
        )

        # Filter out nix-build result symlinks
        || (
          type == "symlink" && lib.hasPrefix "result" baseName
        )

        # Filter out IDE config
        || (
          type == "directory" && (
            baseName == ".idea" || baseName == ".vscode"
          )
        ) || lib.hasSuffix ".iml" baseName

        # Filter out nix build files
        || baseName == "Cargo.nix"

        # Filter out editor backup / swap files.
        || lib.hasSuffix "~" baseName
        || builtins.match "^\\.sw[a-z]$$" baseName != null
        || builtins.match "^\\..*\\.sw[a-z]$$" baseName != null
        || lib.hasSuffix ".tmp" baseName
        || lib.hasSuffix ".bak" baseName
        || baseName == "tests.nix"
      );

  /* Returns a crate which depends on successful test execution
    of crate given as the second argument.

    testCrateFlags: list of flags to pass to the test exectuable
    testInputs: list of packages that should be available during test execution
  */
  crateWithTest = { crate, testCrate, testCrateFlags, testInputs, testPreRun, testPostRun }:
    assert builtins.typeOf testCrateFlags == "list";
    assert builtins.typeOf testInputs == "list";
    assert builtins.typeOf testPreRun == "string";
    assert builtins.typeOf testPostRun == "string";
    let
      # override the `crate` so that it will build and execute tests instead of
      # building the actual lib and bin targets We just have to pass `--test`
      # to rustc and it will do the right thing.  We execute the tests and copy
      # their log and the test executables to $out for later inspection.
      test =
        let
          drv = testCrate.override
            (
              _: {
                buildTests = true;
              }
            );
          # If the user hasn't set any pre/post commands, we don't want to
          # insert empty lines. This means that any existing users of crate2nix
          # don't get a spurious rebuild unless they set these explicitly.
          testCommand = pkgs.lib.concatStringsSep "\n"
            (pkgs.lib.filter (s: s != "") [
              testPreRun
              "$f $testCrateFlags 2>&1 | tee -a $out"
              testPostRun
            ]);
        in
        pkgs.runCommand "run-tests-${testCrate.name}"
          {
            inherit testCrateFlags;
            buildInputs = testInputs;
          } ''
          set -ex

          export RUST_BACKTRACE=1

          # recreate a file hierarchy as when running tests with cargo

          # the source for test data
          ${pkgs.xorg.lndir}/bin/lndir ${crate.src}

          # build outputs
          testRoot=target/debug
          mkdir -p $testRoot

          # executables of the crate
          # we copy to prevent std::env::current_exe() to resolve to a store location
          for i in ${crate}/bin/*; do
            cp "$i" "$testRoot"
          done
          chmod +w -R .

          # test harness executables are suffixed with a hash, like cargo does
          # this allows to prevent name collision with the main
          # executables of the crate
          hash=$(basename $out)
          for file in ${drv}/tests/*; do
            f=$testRoot/$(basename $file)-$hash
            cp $file $f
            ${testCommand}
          done
        '';
    in
    pkgs.runCommand "${crate.name}-linked"
      {
        inherit (crate) outputs crateName;
        passthru = (crate.passthru or { }) // {
          inherit test;
        };
      } ''
      echo tested by ${test}
      ${lib.concatMapStringsSep "\n" (output: "ln -s ${crate.${output}} ${"$"}${output}") crate.outputs}
    '';

  /* A restricted overridable version of builtRustCratesWithFeatures. */
  buildRustCrateWithFeatures =
    { packageId
    , features ? rootFeatures
    , crateOverrides ? defaultCrateOverrides
    , buildRustCrateForPkgsFunc ? null
    , runTests ? false
    , testCrateFlags ? [ ]
    , testInputs ? [ ]
      # Any command to run immediatelly before a test is executed.
    , testPreRun ? ""
      # Any command run immediatelly after a test is executed.
    , testPostRun ? ""
    }:
    lib.makeOverridable
      (
        { features
        , crateOverrides
        , runTests
        , testCrateFlags
        , testInputs
        , testPreRun
        , testPostRun
        }:
        let
          buildRustCrateForPkgsFuncOverriden =
            if buildRustCrateForPkgsFunc != null
            then buildRustCrateForPkgsFunc
            else
              (
                if crateOverrides == pkgs.defaultCrateOverrides
                then buildRustCrateForPkgs
                else
                  pkgs: (buildRustCrateForPkgs pkgs).override {
                    defaultCrateOverrides = crateOverrides;
                  }
              );
          builtRustCrates = builtRustCratesWithFeatures {
            inherit packageId features;
            buildRustCrateForPkgsFunc = buildRustCrateForPkgsFuncOverriden;
            runTests = false;
          };
          builtTestRustCrates = builtRustCratesWithFeatures {
            inherit packageId features;
            buildRustCrateForPkgsFunc = buildRustCrateForPkgsFuncOverriden;
            runTests = true;
          };
          drv = builtRustCrates.crates.${packageId};
          testDrv = builtTestRustCrates.crates.${packageId};
          derivation =
            if runTests then
              crateWithTest
                {
                  crate = drv;
                  testCrate = testDrv;
                  inherit testCrateFlags testInputs testPreRun testPostRun;
                }
            else drv;
        in
        derivation
      )
      { inherit features crateOverrides runTests testCrateFlags testInputs testPreRun testPostRun; };

  /* Returns an attr set with packageId mapped to the result of buildRustCrateForPkgsFunc
    for the corresponding crate.
  */
  builtRustCratesWithFeatures =
    { packageId
    , features
    , crateConfigs ? crates
    , buildRustCrateForPkgsFunc
    , runTests
    , target ? defaultTarget
    } @ args:
      assert (builtins.isAttrs crateConfigs);
      assert (builtins.isString packageId);
      assert (builtins.isList features);
      assert (builtins.isAttrs target);
      assert (builtins.isBool runTests);
      let
        rootPackageId = packageId;
        mergedFeatures = mergePackageFeatures
          (
            args // {
              inherit rootPackageId;
              target = target // { test = runTests; };
            }
          );
        # Memoize built packages so that reappearing packages are only built once.
        builtByPackageIdByPkgs = mkBuiltByPackageIdByPkgs pkgs;
        mkBuiltByPackageIdByPkgs = pkgs:
          let
            self = {
              crates = lib.mapAttrs (packageId: value: buildByPackageIdForPkgsImpl self pkgs packageId) crateConfigs;
              build = mkBuiltByPackageIdByPkgs pkgs.buildPackages;
            };
          in
          self;
        buildByPackageIdForPkgsImpl = self: pkgs: packageId:
          let
            features = mergedFeatures."${packageId}" or [ ];
            crateConfig' = crateConfigs."${packageId}";
            crateConfig =
              builtins.removeAttrs crateConfig' [ "resolvedDefaultFeatures" "devDependencies" ];
            devDependencies =
              lib.optionals
                (runTests && packageId == rootPackageId)
                (crateConfig'.devDependencies or [ ]);
            dependencies =
              dependencyDerivations {
                inherit features target;
                buildByPackageId = depPackageId:
                  # proc_macro crates must be compiled for the build architecture
                  if crateConfigs.${depPackageId}.procMacro or false
                  then self.build.crates.${depPackageId}
                  else self.crates.${depPackageId};
                dependencies =
                  (crateConfig.dependencies or [ ])
                  ++ devDependencies;
              };
            buildDependencies =
              dependencyDerivations {
                inherit features target;
                buildByPackageId = depPackageId:
                  self.build.crates.${depPackageId};
                dependencies = crateConfig.buildDependencies or [ ];
              };
            filterEnabledDependenciesForThis = dependencies: filterEnabledDependencies {
              inherit dependencies features target;
            };
            dependenciesWithRenames =
              lib.filter (d: d ? "rename")
                (
                  filterEnabledDependenciesForThis
                    (
                      (crateConfig.buildDependencies or [ ])
                      ++ (crateConfig.dependencies or [ ])
                      ++ devDependencies
                    )
                );
            # Crate renames have the form:
            #
            # {
            #    crate_name = [
            #       { version = "1.2.3"; rename = "crate_name01"; }
            #    ];
            #    # ...
            # }
            crateRenames =
              let
                grouped =
                  lib.groupBy
                    (dependency: dependency.name)
                    dependenciesWithRenames;
                versionAndRename = dep:
                  let
                    package = crateConfigs."${dep.packageId}";
                  in
                  { inherit (dep) rename; version = package.version; };
              in
              lib.mapAttrs (name: choices: builtins.map versionAndRename choices) grouped;
          in
          buildRustCrateForPkgsFunc pkgs
            (
              crateConfig // {
                src = crateConfig.src or (
                  pkgs.fetchurl rec {
                    name = "${crateConfig.crateName}-${crateConfig.version}.tar.gz";
                    # https://www.pietroalbini.org/blog/downloading-crates-io/
                    # Not rate-limited, CDN URL.
                    url = "https://static.crates.io/crates/${crateConfig.crateName}/${crateConfig.crateName}-${crateConfig.version}.crate";
                    sha256 =
                      assert (lib.assertMsg (crateConfig ? sha256) "Missing sha256 for ${name}");
                      crateConfig.sha256;
                  }
                );
                extraRustcOpts = lib.lists.optional (targetFeatures != [ ]) "-C target-feature=${lib.concatMapStringsSep "," (x: "+${x}") targetFeatures}";
                inherit features dependencies buildDependencies crateRenames release;
              }
            );
      in
      builtByPackageIdByPkgs;

  /* Returns the actual derivations for the given dependencies. */
  dependencyDerivations =
    { buildByPackageId
    , features
    , dependencies
    , target
    }:
      assert (builtins.isList features);
      assert (builtins.isList dependencies);
      assert (builtins.isAttrs target);
      let
        enabledDependencies = filterEnabledDependencies {
          inherit dependencies features target;
        };
        depDerivation = dependency: buildByPackageId dependency.packageId;
      in
      map depDerivation enabledDependencies;

  /* Returns a sanitized version of val with all values substituted that cannot
    be serialized as JSON.
  */
  sanitizeForJson = val:
    if builtins.isAttrs val
    then lib.mapAttrs (n: v: sanitizeForJson v) val
    else if builtins.isList val
    then builtins.map sanitizeForJson val
    else if builtins.isFunction val
    then "function"
    else val;

  /* Returns various tools to debug a crate. */
  debugCrate = { packageId, target ? defaultTarget }:
    assert (builtins.isString packageId);
    let
      debug = rec {
        # The built tree as passed to buildRustCrate.
        buildTree = buildRustCrateWithFeatures {
          buildRustCrateForPkgsFunc = _: lib.id;
          inherit packageId;
        };
        sanitizedBuildTree = sanitizeForJson buildTree;
        dependencyTree = sanitizeForJson
          (
            buildRustCrateWithFeatures {
              buildRustCrateForPkgsFunc = _: crate: {
                "01_crateName" = crate.crateName or false;
                "02_features" = crate.features or [ ];
                "03_dependencies" = crate.dependencies or [ ];
              };
              inherit packageId;
            }
          );
        mergedPackageFeatures = mergePackageFeatures {
          features = rootFeatures;
          inherit packageId target;
        };
        diffedDefaultPackageFeatures = diffDefaultPackageFeatures {
          inherit packageId target;
        };
      };
    in
    { internal = debug; };

  /* Returns differences between cargo default features and crate2nix default
    features.

    This is useful for verifying the feature resolution in crate2nix.
  */
  diffDefaultPackageFeatures =
    { crateConfigs ? crates
    , packageId
    , target
    }:
      assert (builtins.isAttrs crateConfigs);
      let
        prefixValues = prefix: lib.mapAttrs (n: v: { "${prefix}" = v; });
        mergedFeatures =
          prefixValues
            "crate2nix"
            (mergePackageFeatures { inherit crateConfigs packageId target; features = [ "default" ]; });
        configs = prefixValues "cargo" crateConfigs;
        combined = lib.foldAttrs (a: b: a // b) { } [ mergedFeatures configs ];
        onlyInCargo =
          builtins.attrNames
            (lib.filterAttrs (n: v: !(v ? "crate2nix") && (v ? "cargo")) combined);
        onlyInCrate2Nix =
          builtins.attrNames
            (lib.filterAttrs (n: v: (v ? "crate2nix") && !(v ? "cargo")) combined);
        differentFeatures = lib.filterAttrs
          (
            n: v:
              (v ? "crate2nix")
              && (v ? "cargo")
              && (v.crate2nix.features or [ ]) != (v."cargo".resolved_default_features or [ ])
          )
          combined;
      in
      builtins.toJSON {
        inherit onlyInCargo onlyInCrate2Nix differentFeatures;
      };

  /* Returns an attrset mapping packageId to the list of enabled features.

    If multiple paths to a dependency enable different features, the
    corresponding feature sets are merged. Features in rust are additive.
  */
  mergePackageFeatures =
    { crateConfigs ? crates
    , packageId
    , rootPackageId ? packageId
    , features ? rootFeatures
    , dependencyPath ? [ crates.${packageId}.crateName ]
    , featuresByPackageId ? { }
    , target
      # Adds devDependencies to the crate with rootPackageId.
    , runTests ? false
    , ...
    } @ args:
      assert (builtins.isAttrs crateConfigs);
      assert (builtins.isString packageId);
      assert (builtins.isString rootPackageId);
      assert (builtins.isList features);
      assert (builtins.isList dependencyPath);
      assert (builtins.isAttrs featuresByPackageId);
      assert (builtins.isAttrs target);
      assert (builtins.isBool runTests);
      let
        crateConfig = crateConfigs."${packageId}" or (builtins.throw "Package not found: ${packageId}");
        expandedFeatures = expandFeatures (crateConfig.features or { }) features;
        enabledFeatures = enableFeatures (crateConfig.dependencies or [ ]) expandedFeatures;
        depWithResolvedFeatures = dependency:
          let
            packageId = dependency.packageId;
            features = dependencyFeatures enabledFeatures dependency;
          in
          { inherit packageId features; };
        resolveDependencies = cache: path: dependencies:
          assert (builtins.isAttrs cache);
          assert (builtins.isList dependencies);
          let
            enabledDependencies = filterEnabledDependencies {
              inherit dependencies target;
              features = enabledFeatures;
            };
            directDependencies = map depWithResolvedFeatures enabledDependencies;
            foldOverCache = op: lib.foldl op cache directDependencies;
          in
          foldOverCache
            (
              cache: { packageId, features }:
                let
                  cacheFeatures = cache.${packageId} or [ ];
                  combinedFeatures = sortedUnique (cacheFeatures ++ features);
                in
                if cache ? ${packageId} && cache.${packageId} == combinedFeatures
                then cache
                else
                  mergePackageFeatures {
                    features = combinedFeatures;
                    featuresByPackageId = cache;
                    inherit crateConfigs packageId target runTests rootPackageId;
                  }
            );
        cacheWithSelf =
          let
            cacheFeatures = featuresByPackageId.${packageId} or [ ];
            combinedFeatures = sortedUnique (cacheFeatures ++ enabledFeatures);
          in
          featuresByPackageId // {
            "${packageId}" = combinedFeatures;
          };
        cacheWithDependencies =
          resolveDependencies cacheWithSelf "dep"
            (
              crateConfig.dependencies or [ ]
              ++ lib.optionals
                (runTests && packageId == rootPackageId)
                (crateConfig.devDependencies or [ ])
            );
        cacheWithAll =
          resolveDependencies
            cacheWithDependencies "build"
            (crateConfig.buildDependencies or [ ]);
      in
      cacheWithAll;

  /* Returns the enabled dependencies given the enabled features. */
  filterEnabledDependencies = { dependencies, features, target }:
    assert (builtins.isList dependencies);
    assert (builtins.isList features);
    assert (builtins.isAttrs target);

    lib.filter
      (
        dep:
        let
          targetFunc = dep.target or (features: true);
        in
        targetFunc { inherit features target; }
        && (
          !(dep.optional or false)
          || builtins.any (doesFeatureEnableDependency dep) features
        )
      )
      dependencies;

  /* Returns whether the given feature should enable the given dependency. */
  doesFeatureEnableDependency = { name, rename ? null, ... }: feature:
    let
      prefix = "${name}/";
      len = builtins.stringLength prefix;
      startsWithPrefix = builtins.substring 0 len feature == prefix;
    in
    (rename == null && feature == name)
    || (rename != null && rename == feature)
    || startsWithPrefix;

  /* Returns the expanded features for the given inputFeatures by applying the
    rules in featureMap.

    featureMap is an attribute set which maps feature names to lists of further
    feature names to enable in case this feature is selected.
  */
  expandFeatures = featureMap: inputFeatures:
    assert (builtins.isAttrs featureMap);
    assert (builtins.isList inputFeatures);
    let
      expandFeature = feature:
        assert (builtins.isString feature);
        [ feature ] ++ (expandFeatures featureMap (featureMap."${feature}" or [ ]));
      outFeatures = lib.concatMap expandFeature inputFeatures;
    in
    sortedUnique outFeatures;

  /* This function adds optional dependencies as features if they are enabled
    indirectly by dependency features. This function mimics Cargo's behavior
    described in a note at:
    https://doc.rust-lang.org/nightly/cargo/reference/features.html#dependency-features
  */
  enableFeatures = dependencies: features:
    assert (builtins.isList features);
    assert (builtins.isList dependencies);
    let
      additionalFeatures = lib.concatMap
        (
          dependency:
            assert (builtins.isAttrs dependency);
            let
              enabled = builtins.any (doesFeatureEnableDependency dependency) features;
            in
            if (dependency.optional or false) && enabled then [ dependency.name ] else [ ]
        )
        dependencies;
    in
    sortedUnique (features ++ additionalFeatures);

  /*
    Returns the actual features for the given dependency.

    features: The features of the crate that refers this dependency.
  */
  dependencyFeatures = features: dependency:
    assert (builtins.isList features);
    assert (builtins.isAttrs dependency);
    let
      defaultOrNil =
        if dependency.usesDefaultFeatures or true
        then [ "default" ]
        else [ ];
      explicitFeatures = dependency.features or [ ];
      additionalDependencyFeatures =
        let
          dependencyPrefix = (dependency.rename or dependency.name) + "/";
          dependencyFeatures =
            builtins.filter (f: lib.hasPrefix dependencyPrefix f) features;
        in
        builtins.map (lib.removePrefix dependencyPrefix) dependencyFeatures;
    in
    defaultOrNil ++ explicitFeatures ++ additionalDependencyFeatures;

  /* Sorts and removes duplicates from a list of strings. */
  sortedUnique = features:
    assert (builtins.isList features);
    assert (builtins.all builtins.isString features);
    let
      outFeaturesSet = lib.foldl (set: feature: set // { "${feature}" = 1; }) { } features;
      outFeaturesUnique = builtins.attrNames outFeaturesSet;
    in
    builtins.sort (a: b: a < b) outFeaturesUnique;

  deprecationWarning = message: value:
    if strictDeprecation
    then builtins.throw "strictDeprecation enabled, aborting: ${message}"
    else builtins.trace message value;

  #
  # crate2nix/default.nix (excerpt end)
  #
  };
}

