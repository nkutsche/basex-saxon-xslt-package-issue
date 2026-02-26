package com.nkutsche.issues;


import net.sf.saxon.s9api.*;
import org.w3c.dom.Document;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.stream.StreamSource;
import java.io.File;
import java.io.FileNotFoundException;

public class SaxonCaller {

    public static void main(String[] args) throws Exception {
        System.out.println(transform("test.xml", "test.xsl"));
        System.out.println("-----");
        System.out.println(transform("test.xml","test.xsl"));
    }


    public static String transform(String inputPath, String xsltPath) throws Exception {
        try {
            Processor processor = new Processor(false);
            XsltCompiler compiler = processor.newXsltCompiler();

            File xsltFile = new File(xsltPath);
            File xmlFile = new File(inputPath);
            if (!xsltFile.exists()) {
                throw new FileNotFoundException("XSLT file not found at: " + xsltPath);
            }
            XsltExecutable executable = compiler.compile(new StreamSource(xsltFile));
            XsltTransformer transformer = executable.load();

            XdmNode source = processor.newDocumentBuilder().build(new StreamSource(xmlFile));

            DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
            dbf.setNamespaceAware(true);
            Document resultDoc = dbf.newDocumentBuilder().newDocument();

            RawDestination destination = new RawDestination();

            transformer.setInitialContextNode(source);
            transformer.setDestination(destination);
            transformer.transform();

            Serializer serializer = processor.newSerializer();
            return serializer.serializeNodeToString((XdmNode) destination.getXdmValue());
        }
        catch (Exception e){
            System.out.println(e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

}
