# AuthClassLib

AuthPlatelet: Built-In Formal Verification in Every Authentication/Authorization Flow

Please run make.bat before running examples.

There are three Visual Studio solutions included in this repository. They are src\AuthClassLib, src\Examples and src\ProjectBuilder.

src\AuthClassLib: AuthPlatelet implementations.

src\Examples: Four concrete scenarios using Live ID, Yahoo Login and Facebook Connect services for authentication and authorization.

src\Examples\ABC: ABC example we explain in the paper. In order to run this example, you need to select multiple startup projects, and run in order of Server_A, Server_B, Server_C, and Run_ABC.

src\Examples\LiveIDLogin: Set LiveIDExample as startup project to run this example. Also, you need to install Internet Information Services (IIS) Manager,
                          and add a site named LiveIDExample with host name as a.local.host with port number 14022. Also, Anonymous Authentication should be on, and
                          Application Pool should be LocalSystem.

src\Examples\OpenIDLogin: Set OpenIDExample as startup project to run this example.

src\Examples\FacebookGraphAuth: Set FacebookGraphApiExample to run this example. You need to log in Facebook as johndoe.test.789@gmail.com. Please email authplatelet@gmail.com
                                for credentials to test this example.

src\Examples\CILRepository: This is source for the certification server.                                                                  

src\ProjectBuilder: Post-build script for sending the dll at compile time.

If you have any questions, please email authplatelet@gmail.com.
