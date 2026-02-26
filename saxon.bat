@echo off

set DP0=%~dp0

%DP0%\mvnw -f %DP0%\pom.xml compile ^
exec:exec -Dexec.executable="java" ^
-Dexec.args="-DSAXON_INITIALIZER=com.nkutsche.xslt.pkg.handler.PackageManager -cp target\classes;%%classpath com.nkutsche.issues.SaxonCaller"