# json;;
- : Yojson.Basic.t =
`Assoc
  [("success", `Bool true);
   ("result",
    `Assoc
      [("apiVersion", `String "1.0.2"); ("version", `String "1.30.1");
       ("telescopeId", `String "stellina-5df04c"); ("bootCount", `Int 371);
       ("initError", `Null); ("boardInitError", `Null);
       ("boardInDebugMode", `Bool false); ("timestamp", `Int 1646643714594);
       ("elapsedTime", `Int 13199102);
       ("position",
        `Assoc
          [("latitude", `Float 52.2451395999999946);
           ("longitude", `Float 0.079556)]);
       ("initialized", `Bool false); ("autofocusTemperature", `Float 15.5);
       ("shuttingDown", `Bool false);
       ("connectedDevices",
        `List
          [`Assoc
             [("id",
               `String
                 "iOS_Apple_iPad8_6_472AC2D5-B6DE-53DD-A563-BF202DF3203F");
              ("name", `String "Jonathan’s iMac");
              ("user", `String "jonathan@kimmitt.co.uk")];
           `Assoc
             [("id",
               `String
                 "iOS_Apple_iPad4_2_A099E9A7-64D5-42A2-9F65-2D26582481D8");
              ("name", `String "Jonathan’s iPad");
              ("user", `String "Jrrk")];
           `Assoc
             [("id",
               `String
                 "iOS_Apple_iPhone10_4_D4D0075A-0590-4458-81DE-07E9FF3FF2AB");
              ("name", `String "iPhone"); ("user", `String "jrrk2")]]);
       ("masterDeviceId", `Null);
       ("settings",
        `Assoc
          [("telescopeName", `Null);
           ("usbFileTypes",
            `List [`String "RAW"; `String "OUTPUT"; `String "DEBUG"])]);
       ("logs",
        `Assoc
          [("numFiles", `Int 0); ("bufferPosition", `Int 1798);
           ("bufferSize", `Int 500000)]);
       ("availableReports", `Int 1);
       ("update",
        `Assoc
          [("installedVersion", `String "1.30.1");
           ("minimumCompatibleVersion", `String "1.16.0");
           ("state", `String "IDLE")]);
       ("storage",
        `Assoc
          [("system",
            `Assoc [("size", `Int 1900368); ("available", `Int 1235924)]);
           ("data",
            `Assoc [("size", `Int 11075340); ("available", `Int 9904020)]);
           ("usb",
            `Assoc
              [("size", `Int 120147264); ("available", `Int 112248896);
               ("changeCount", `Int 1)])]);
       ("battery", `Assoc [("potentialBatteryCandidates", `List [])]);
       ("sensors",
        `Assoc
          [("temperature", `Float 17.3); ("temperatureDelta", `Int 0);
           ("humidity", `Float 58.1); ("humidityDelta", `Int 0);
           ("defogStatus", `String "OFF");
           ("dewpointDepression", `Float 8.3)]);
       ("motors",
        `Assoc
          [("AZ",
            `Assoc
              [("position", `Int 0); ("state", `String "IDLE");
               ("atStop", `Bool true); ("calibrated", `Bool true)]);
           ("ALT",
            `Assoc
              [("position", `Float (-89.9999988)); ("state", `String "IDLE");
               ("atStop", `Bool true); ("calibrated", `Bool true)]);
           ("DER",
            `Assoc
              [("position", `Int 0); ("state", `String "IDLE");
               ("atStop", `Bool true); ("calibrated", `Bool true)]);
           ("MAP",
            `Assoc
              [("position", `Int 10000); ("state", `String "IDLE");
               ("calibrated", `Bool true)])]);
       ("currentOperation", `Null); ("otherCurrentOperations", `List []);
       ("previousOperations",
        `Assoc
          [("open", `Null);
           ("park",
            `Assoc
              [("id", `String "park-129-371-5df04c");
               ("ctx", `String "/general/park#371-2");
               ("type", `String "PARK"); ("startTime", `Int 1646632382969);
               ("endTime", `Int 1646632418862); ("stopped", `Bool true);
               ("error", `Null)]);
           ("autoInit",
            `Assoc
              [("id", `String "auto_init-1-371-5df04c");
               ("ctx", `String "/general/startAutoInit#371-1");
               ("type", `String "AUTO_INIT");
               ("startTime", `Int 1646630632345);
               ("endTime", `Int 1646631140788); ("stopped", `Bool true);
               ("error",
                `Assoc
                  [("name", `String "GENERAL.ALL_ATTEMPTS_FAILED");
                   ("isFailure", `Bool true)]);
               ("time", `Int 1646630626198);
               ("position",
                `Assoc
                  [("latitude", `Float 52.2451397063242524);
                   ("longitude", `Float 0.07955613642727416)]);
               ("steps",
                `List
                  [`Assoc [("type", `String "PREPARE_MC_BOARD")];
                   `Assoc [("type", `String "SEEK_STOP")];
                   `Assoc [("type", `String "OPEN_ARM")];
                   `Assoc
                     [("type", `String "TRY_POSITION");
                      ("steps",
                       `List
                         [`Assoc [("type", `String "MOVING")];
                          `Assoc
                            [("type", `String "ASTROMETRY");
                             ("error",
                              `Assoc
                                [("name", `String "RUNTIME_ERROR");
                                 ("data", `String "astrometry failed")])];
                          `Assoc
                            [("type",
                              `String "WIDE_AUTOFOCUS_FAILED_ASTROMETRY");
                             ("progress", `Float 1.60869565217391308);
                             ("autoFocus",
                              `Assoc
                                [("map", `Int 92000);
                                 ("focusValue", `Float 128.955)])];
                          `Assoc
                            [("type", `String "RETRY_ASTROMETRY");
                             ("error",
                              `Assoc
                                [("name", `String "RUNTIME_ERROR");
                                 ("data", `String "astrometry failed")])]])];
                   `Assoc
                     [("type", `String "TRY_POSITION");
                      ("steps",
                       `List
                         [`Assoc [("type", `String "MOVING")];
                          `Assoc
                            [("type", `String "ASTROMETRY");
                             ("error",
                              `Assoc
                                [("name", `String "EXTERNALPROCESS.KILLED");
                                 ("chain",
                                  `List
                                    [`Assoc
                                       [("name",
                                         `String "EXTERNALPROCESS.TIMEOUT")]])])]])];
                   `Assoc
                     [("type", `String "TRY_POSITION");
                      ("steps",
                       `List
                         [`Assoc [("type", `String "MOVING")];
                          `Assoc
                            [("type", `String "ASTROMETRY");
                             ("error",
                              `Assoc
                                [("name", `String "EXTERNALPROCESS.KILLED");
                                 ("chain",
                                  `List
                                    [`Assoc
                                       [("name",
                                         `String "EXTERNALPROCESS.TIMEOUT")]])])]])];
                   `Assoc
                     [("type", `String "TRY_POSITION");
                      ("steps",
                       `List
                         [`Assoc [("type", `String "MOVING")];
                          `Assoc
                            [("type", `String "ASTROMETRY");
                             ("error",
                              `Assoc
                                [("name", `String "RUNTIME_ERROR");
                                 ("data", `String "astrometry failed")])]])];
                   `Assoc
                     [("type", `String "TRY_POSITION");
                      ("steps",
                       `List
                         [`Assoc [("type", `String "MOVING")];
                          `Assoc
                            [("type", `String "ASTROMETRY");
                             ("error",
                              `Assoc
                                [("name", `String "RUNTIME_ERROR");
                                 ("data", `String "astrometry failed")])]])];
                   `Assoc
                     [("type", `String "TRY_POSITION");
                      ("steps",
                       `List
                         [`Assoc [("type", `String "MOVING")];
                          `Assoc
                            [("type", `String "ASTROMETRY");
                             ("error",
                              `Assoc
                                [("name", `String "RUNTIME_ERROR");
                                 ("data", `String "astrometry failed")])]])];
                   `Assoc
                     [("type", `String "TRY_POSITION");
                      ("steps",
                       `List
                         [`Assoc [("type", `String "MOVING")];
                          `Assoc
                            [("type", `String "ASTROMETRY");
                             ("error",
                              `Assoc
                                [("name", `String "RUNTIME_ERROR");
                                 ("data", `String "astrometry failed")])]])]])]);
           ("observation",
            `Assoc
              [("id", `String "observation-1337-359-5df04c");
               ("type", `String "OBSERVATION");
               ("startTime", `Int 1646340107719);
               ("endTime", `Int 1646344537273); ("stopped", `Bool true);
               ("error",
                `Assoc
                  [("name", `String "GENERAL.POINTING_STOPPED");
                   ("chain",
                    `List
                      [`Assoc
                         [("name",
                           `String "GENERAL.TOO_MANY_ASTROMETRY_FAILED")]])]);
               ("userId", `Int 2390);
               ("deviceId",
                `String
                  "iOS_Apple_iPhone10_4_D4D0075A-0590-4458-81DE-07E9FF3FF2AB");
               ("appVersion", `String "1.3.4");
               ("observationType", `String "PLAYLIST");
               ("target",
                `Assoc
                  [("ra", `Float 84.025); ("de", `Float 34.133);
                   ("rot", `Int 0); ("objectId", `String "M36");
                   ("objectName", `String "Pinwheel Cluster")]);
               ("framing",
                `Assoc
                  [("ra", `Float 84.031767); ("de", `Float 34.135291);
                   ("rot", `Float 359.376)]);
               ("steps",
                `List
                  [`Assoc
                     [("type", `String "POINT_DEEP_SKY");
                      ("steps",
                       `List
                         [`Assoc [("type", `String "GO_TARGET")];
                          `Assoc [("type", `String "START_TRACKING")];
                          `Assoc
                            [("type", `String "ASTROMETRY");
                             ("astrometryDelta", `Float 0.570864507678088162)];
                          `Assoc [("type", `String "START_TRACKING")];
                          `Assoc [("type", `String "GO_TARGET")];
                          `Assoc [("type", `String "START_TRACKING")];
                          `Assoc
                            [("type", `String "ASTROMETRY");
                             ("astrometryDelta",
                              `Float 0.0125079233719152423)];
                          `Assoc [("type", `String "START_TRACKING")]]);
                      ("name", `String "initial")];
                   `Assoc
                     [("type", `String "CAPTURE");
                      ("name", `String "INITIAL")];
                   `Assoc
                     [("type", `String "POINT_DEEP_SKY");
                      ("steps",
                       `List
                         [`Assoc [("type", `String "GO_TARGET")];
                          `Assoc [("type", `String "START_TRACKING")];
                          `Assoc
                            [("type", `String "ASTROMETRY");
                             ("error",
                              `Assoc
                                [("name", `String "RUNTIME_ERROR");
                                 ("data", `String "astrometry failed")])];
                          `Assoc [("type", `String "GO_TARGET")];
                          `Assoc [("type", `String "START_TRACKING")];
                          `Assoc
                            [("type", `String "ASTROMETRY");
                             ("error",
                              `Assoc
                                [("name", `String "RUNTIME_ERROR");
                                 ("data", `String "astrometry failed")])];
                          `Assoc [("type", `String "GO_TARGET")];
                          `Assoc [("type", `String "START_TRACKING")];
                          `Assoc
                            [("type", `String "ASTROMETRY");
                             ("error",
                              `Assoc
                                [("name", `String "RUNTIME_ERROR");
                                 ("data", `String "astrometry failed")])];
                          `Assoc [("type", `String "GO_TARGET")];
                          `Assoc [("type", `String "START_TRACKING")];
                          `Assoc
                            [("type", `String "ASTROMETRY");
                             ("error",
                              `Assoc
                                [("name", `String "RUNTIME_ERROR");
                                 ("data", `String "astrometry failed")])];
                          `Assoc [("type", `String "GO_TARGET")];
                          `Assoc [("type", `String "START_TRACKING")];
                          `Assoc
                            [("type", `String "ASTROMETRY");
                             ("error",
                              `Assoc
                                [("name", `String "RUNTIME_ERROR");
                                 ("data", `String "astrometry failed")])];
                          `Assoc [("type", `String "GO_TARGET")];
                          `Assoc [("type", `String "START_TRACKING")];
                          `Assoc
                            [("type", `String "ASTROMETRY");
                             ("error",
                              `Assoc
                                [("name", `String "RUNTIME_ERROR");
                                 ("data", `String "astrometry failed")])]]);
                      ("name", `String "bad-registration")]]);
               ("actionInProgress", `Bool true);
               ("capture",
                `Assoc
                  [("id", `String "capture-1362-359-5df04c");
                   ("ctx", `String "/playlist/startPlaylist#359-106");
                   ("startTime", `Int 1646340199997);
                   ("endTime", `Int 1646344537278); ("stopped", `Bool true);
                   ("error",
                    `Assoc
                      [("name", `String "OPERATION.INTERRUPTED_BY_PARENT");
                       ("data", `Assoc [("byOp", `String "OBSERVATION")])]);
                   ("captureType", `String "INITIAL");
                   ("cameraParams",
                    `Assoc
                      [("exposureMicroSec", `Int 10000000);
                       ("gain", `Int 200); ("width", `Int 3072);
                       ("height", `Int 2080)]);
                   ("target",
                    `Assoc
                      [("ra", `Float 84.025); ("de", `Float 34.133);
                       ("rot", `Int 0); ("objectId", `String "M36");
                       ("objectName", `String "Pinwheel Cluster")]);
                   ("position",
                    `Assoc
                      [("latitude", `Float 52.2452);
                       ("longitude", `Float 0.0797)]);
                   ("hasStacking", `Bool true);
                   ("acquisitionCount", `Int 285);
                   ("startHumidity", `Float 87.1);
                   ("startTemperature", `Int 8);
                   ("endHumidity", `Float 89.8);
                   ("endTemperature", `Float 7.3);
                   ("stackingCount", `Int 222);
                   ("stackingErrorCount", `Int 63);
                   ("outputImageCount", `Int 222);
                   ("outputImageErrorCount", `Int 0);
                   ("debayerInterpolation", `String "VNG");
                   ("stackingErrorMap",
                    `Assoc
                      [("StackingRoundnessError", `Int 59);
                       ("StackingMatchingError", `Int 2);
                       ("StackingLackOfStar", `Int 2)]);
                   ("images",
                    `List
                      [`Assoc
                         [("index", `Int 0);
                          ("url",
                           `String
                             "/files/captures/2022-03-03_20-43-19/images/IMG_0001.jpeg");
                          ("cropX", `Int 0); ("cropY", `Int 0);
                          ("cropWidth", `Int 3072);
                          ("cropHeight", `Int 2080);
                          ("stackingCount", `Int 1);
                          ("stackingErrorCount", `Int 0);
                          ("time", `Int 8939825)];
                       `Assoc
                         [("index", `Int 1);
                          ("url",
                           `String
                             "/files/captures/2022-03-03_20-43-19/images/IMG_0002.jpeg");
                          ("cropX", `Int 0); ("cropY", `Int 0);
                          ("cropWidth", `Int 3072);
                          ("cropHeight", `Int 2080);
                          ("stackingCount", `Int 2);
                          ("stackingErrorCount", `Int 0);
                          ("time", `Int 8950198)];
                       `Assoc
                         [("index", `Int 3);
                          ("url",
                           `String
                             "/files/captures/2022-03-03_20-43-19/images/IMG_0004.jpeg");
                          ("cropX", `Int 0); ("cropY", `Int 0);
                          ("cropWidth", `Int 3072);
                          ("cropHeight", `Int 2080);
                          ("stackingCount", `Int 4);
                          ("stackingErrorCount", `Int 0);
                          ("time", `Int 8970959)];
                       `Assoc
                         [("index", `Int 7);
                          ("url",
                           `String
                             "/files/captures/2022-03-03_20-43-19/images/IMG_0008.jpeg");
                          ("cropX", `Int 4); ("cropY", `Int 12);
                          ("cropWidth", `Int 3056);
                          ("cropHeight", `Int 2056);
                          ("stackingCount", `Int 8);
                          ("stackingErrorCount", `Int 0);
                          ("time", `Int 9012494)];
                       `Assoc
                         [("index", `Int 15);
                          ("url",
                           `String
                             "/files/captures/2022-03-03_20-43-19/images/IMG_0016.jpeg");
                          ("cropX", `Int 19); ("cropY", `Int 17);
                          ("cropWidth", `Int 3031);
                          ("cropHeight", `Int 2041);
                          ("stackingCount", `Int 16);
                          ("stackingErrorCount", `Int 2);
                          ("time", `Int 9158136)];
                       `Assoc
                         [("index", `Int 31);
                          ("url",
                           `String
                             "/files/captures/2022-03-03_20-43-19/images/IMG_0032.jpeg");
                          ("cropX", `Int 60); ("cropY", `Int 22);
                          ("cropWidth", `Int 2954);
                          ("cropHeight", `Int 1998);
                          ("stackingCount", `Int 32);
                          ("stackingErrorCount", `Int 9);
                          ("time", `Int 9485070)];
                       `Assoc
                         [("index", `Int 63);
                          ("url",
                           `String
                             "/files/captures/2022-03-03_20-43-19/images/IMG_0064.jpeg");
                          ("cropX", `Int 50); ("cropY", `Int 24);
                          ("cropWidth", `Int 2977);
                          ("cropHeight", `Int 2006);
                          ("stackingCount", `Int 64);
                          ("stackingErrorCount", `Int 20);
                          ("time", `Int 10091847)];
                       `Assoc
                         [("index", `Int 95);
                          ("url",
                           `String
                             "/files/captures/2022-03-03_20-43-19/images/IMG_0096.jpeg");
                          ("cropX", `Int 58); ("cropY", `Int 26);
                          ("cropWidth", `Int 2969);
                          ("cropHeight", `Int 1996);
                          ("stackingCount", `Int 96);
                          ("stackingErrorCount", `Int 25);
                          ("time", `Int 10652840)];
                       `Assoc
                         [("index", `Int 127);
                          ("url",
                           `String
                             "/files/captures/2022-03-03_20-43-19/images/IMG_0128.jpeg");
                          ("cropX", `Int 57); ("cropY", `Int 24);
                          ("cropWidth", `Int 2969);
                          ("cropHeight", `Int 1999);
                          ("stackingCount", `Int 128);
                          ("stackingErrorCount", `Int 31);
                          ("time", `Int 11255130)];
                       `Assoc
                         [("index", `Int 191);
                          ("url",
                           `String
                             "/files/captures/2022-03-03_20-43-19/images/IMG_0192.jpeg");
                          ("cropX", `Int 51); ("cropY", `Int 37);
                          ("cropWidth", `Int 2976);
                          ("cropHeight", `Int 1992);
                          ("stackingCount", `Int 192);
                          ("stackingErrorCount", `Int 42);
                          ("time", `Int 12418794)];
                       `Assoc
                         [("index", `Int 220);
                          ("url",
                           `String
                             "/files/captures/2022-03-03_20-43-19/images/IMG_0221.jpeg");
                          ("cropX", `Int 49); ("cropY", `Int 34);
                          ("cropWidth", `Int 2982);
                          ("cropHeight", `Int 1997);
                          ("stackingCount", `Int 221);
                          ("stackingErrorCount", `Int 55);
                          ("time", `Int 13010852)];
                       `Assoc
                         [("index", `Int 221);
                          ("url",
                           `String
                             "/files/captures/2022-03-03_20-43-19/images/IMG_0222.jpeg");
                          ("cropX", `Int 49); ("cropY", `Int 34);
                          ("cropWidth", `Int 2981);
                          ("cropHeight", `Int 1997);
                          ("stackingCount", `Int 222);
                          ("stackingErrorCount", `Int 55);
                          ("time", `Int 13021231)]])]);
               ("isRestored", `Bool true)]);
           ("sunMode", `Null);
           ("plan",
            `Assoc
              [("id", `String "plan-64-353-5df04c");
               ("type", `String "PLAN"); ("startTime", `Int 1645903111624);
               ("endTime", `Int 1645941037723); ("stopped", `Bool true);
               ("userId", `Int 2390);
               ("deviceId",
                `String
                  "iOS_Apple_iPhone10_4_D4D0075A-0590-4458-81DE-07E9FF3FF2AB");
               ("appVersion", `String "1.3.4");
               ("userName", `String "jrrk2");
               ("planId", `String "079e8f29-a083-4b4d-b7d4-84ef95092035");
               ("planVersion",
                `String "aec12c90-3ab9-4cdc-a42d-796aa5d0bc13");
               ("planName", `String "My plan");
               ("state", `String "OBSERVATION");
               ("targets",
                `List
                  [`Assoc
                     [("startTime", `Int 1645900935512);
                      ("endTime", `Int 1645914009600);
                      ("target",
                       `Assoc
                         [("ra", `Float 38.175); ("de", `Float 61.45);
                          ("rot", `Int 0); ("objectId", `String "IC1805");
                          ("objectName", `String "Heart Nebula")]);
                      ("attempts",
                       `List
                         [`Assoc
                            [("startTime", `Int 1645903111708);
                             ("endTime", `Int 1645914025412);
                             ("observationId",
                              `String "observation-65-353-5df04c");
                             ("lastImage",
                              `Assoc
                                [("index", `Int 482);
                                 ("url",
                                  `String
                                    "/files/plans/target-1-observation-0/images/IMG_0483.jpeg");
                                 ("cropX", `Int 50); ("cropY", `Int 23);
                                 ("cropWidth", `Int 2971);
                                 ("cropHeight", `Int 2006);
                                 ("stackingCount", `Int 483);
                                 ("stackingErrorCount", `Int 48);
                                 ("time", `Int 11029605)]);
                             ("stackingCount", `Int 484)]])];
                   `Assoc
                     [("startTime", `Int 1645914009600);
                      ("endTime", `Int 1645941135512);
                      ("target",
                       `Assoc
                         [("ra", `Float 192.725); ("de", `Float 41.117);
                          ("rot", `Int 0); ("objectId", `String "M94");
                          ("objectName", `String "Cat’s Eye Galaxy")]);
                      ("attempts",
                       `List
                         [`Assoc
                            [("startTime", `Int 1645914025426);
                             ("endTime", `Int 1645914175841);
                             ("observationId",
                              `String "observation-1228-353-5df04c");
                             ("error",
                              `Assoc
                                [("name", `String "GENERAL.POINTING_STOPPED");
                                 ("chain",
                                  `List
                                    [`Assoc
                                       [("name",
                                         `String
                                           "GENERAL.POST_POINTING_ASTROMETRY_FAILED");
                                        ("isFailure", `Bool true)]])])];
                          `Assoc
                            [("startTime", `Int 1645914235848);
                             ("endTime", `Int 1645923557226);
                             ("observationId",
                              `String "observation-1252-353-5df04c");
                             ("error",
                              `Assoc
                                [("name", `String "GENERAL.POINTING_STOPPED");
                                 ("chain",
                                  `List
                                    [`Assoc
                                       [("name",
                                         `String
                                           "GENERAL.POST_GUIDING_ASTROMETRY_FAILED");
                                        ("isFailure", `Bool true)]])]);
                             ("lastImage",
                              `Assoc
                                [("index", `Int 393);
                                 ("url",
                                  `String
                                    "/files/plans/target-2-observation-1/images/IMG_0394.jpeg");
                                 ("cropX", `Int 57); ("cropY", `Int 58);
                                 ("cropWidth", `Int 2957);
                                 ("cropHeight", `Int 2000);
                                 ("stackingCount", `Int 394);
                                 ("stackingErrorCount", `Int 402);
                                 ("time", `Int 20407169)]);
                             ("stackingCount", `Int 394)];
                          `Assoc
                            [("startTime", `Int 1645923797233);
                             ("endTime", `Int 1645923930484);
                             ("observationId",
                              `String "observation-2535-353-5df04c");
                             ("error",
                              `Assoc
                                [("name", `String "GENERAL.POINTING_STOPPED");
                                 ("chain",
                                  `List
                                    [`Assoc
                                       [("name",
                                         `String
                                           "GENERAL.POST_GUIDING_ASTROMETRY_FAILED");
                                        ("isFailure", `Bool true)]])])];
                          `Assoc
                            [("startTime", `Int 1645924470495);
                             ("endTime", `Int 1645924594682);
                             ("observationId",
                              `String "observation-2556-353-5df04c");
                             ("error",
                              `Assoc
                                [("name", `String "GENERAL.POINTING_STOPPED");
                                 ("chain",
                                  `List
                                    [`Assoc
                                       [("name",
                                         `String
                                           "GENERAL.POST_GUIDING_ASTROMETRY_FAILED");
                                        ("isFailure", `Bool true)]])])];
                          `Assoc
                            [("startTime", `Int 1645925554690);
                             ("endTime", `Int 1645941037718);
                             ("observationId",
                              `String "observation-2577-353-5df04c");
                             ("error",
                              `Assoc
                                [("name", `String "GENERAL.SUN_TOO_HIGH")]);
                             ("lastImage",
                              `Assoc
                                [("index", `Int 682);
                                 ("url",
                                  `String
                                    "/files/plans/target-2-observation-4/images/IMG_0683.jpeg");
                                 ("cropX", `Int 44); ("cropY", `Int 53);
                                 ("cropWidth", `Int 2975);
                                 ("cropHeight", `Int 1975);
                                 ("stackingCount", `Int 683);
                                 ("stackingErrorCount", `Int 647);
                                 ("time", `Int 38114358)]);
                             ("stackingCount", `Int 684)]])]])]);
           ("storageAcquisition", `Null)]);
       ("planner", `Assoc [])])]
# 
