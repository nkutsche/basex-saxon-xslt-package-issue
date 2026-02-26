package com.nkutsche.issues;


import net.sf.saxon.s9api.*;
import net.sf.saxon.trans.XPathException;
import net.sf.saxon.trans.packages.PackageDetails;
import net.sf.saxon.trans.packages.PackageLibrary;
import net.sf.saxon.trans.packages.VersionedPackageName;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.stream.StreamSource;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;

public class SaxonCaller {

    private ArrayList<PackageDetails> packageDetails = createPackages();

    private static ArrayList<PackageDetails> createPackages(){
        ArrayList<PackageDetails> packageDetails = new ArrayList<>();
        try {
            packageDetails.add(getPackage(
                    "/pkg/com/nkutsche/xpath-model/xsl/xpath-model-pkg.xsl",
                    "http://www.nkutsche.com/xpath-model",
                    "1.1.0"
            ));
            packageDetails.add(getPackage(
                    "/pkg/io/github/maxtoroq/rng-xsl/rng-package.xsl",
                    "http://maxtoroq.github.io/rng-xsl",
                    "1.1.0"
            ));
        } catch (Exception e){}

        return packageDetails;
    }


    void doit() throws Exception {
        System.out.println(transform("test.xml", "test.xsl", this.packageDetails));
        System.out.println("-----");
        System.out.println(transform("test.xml","test.xsl", this.packageDetails));
        System.out.println("-----");
        System.out.println(transform("test.xml","test.xsl", createPackages()));
    }

    public static void main(String[] args) throws Exception {
        new SaxonCaller().doit();
    }


    private String transform(String inputPath, String xsltPath, ArrayList<PackageDetails> packages) throws Exception {

        try {
            Processor processor = new Processor(false);
            init(
                    processor
                            .getUnderlyingConfiguration()
                            .getDefaultXsltCompilerInfo()
                            .getPackageLibrary(),
                    packages
            );

            XsltExecutable executable = processor.newXsltCompiler().compile(new StreamSource(new File(xsltPath)));
            XsltTransformer transformer = executable.load();
            XdmNode source = processor.newDocumentBuilder().build(new StreamSource(new File(inputPath)));

            RawDestination destination = new RawDestination();

            transformer.setInitialContextNode(source);
            transformer.setDestination(destination);
            transformer.transform();
            return processor.newSerializer().serializeNodeToString((XdmNode) destination.getXdmValue());
        }
        catch (Exception e){
            System.out.println(e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    private void init(PackageLibrary library, ArrayList<PackageDetails> packages) {
        for (PackageDetails pkg:
                packages) {
            library.addPackage(pkg);
        }
    }

    private static PackageDetails getPackage(String pkg, String name, String version) throws IOException, XPathException {
        URL pkgUrl = SaxonCaller.class.getResource(pkg);
        PackageDetails details = new PackageDetails();
        details.nameAndVersion = new VersionedPackageName(name, version);
        details.sourceLocation = new StreamSource(pkgUrl.openStream(), pkgUrl.toString());
        return details;
    }

}
