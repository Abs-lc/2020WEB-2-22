package bbs;

/**
 * <p>�����ַ����Ĵ��� </p>
 */
import java.lang.*;
import java.util.*;

public class DataFormat implements java.io.Serializable{
  public DataFormat() {  }
  /**
   * ���ַ���ת�����ʺ�����ҳ��ʾ���ı�
   * @param s
   * @return
   */
  public static String toHtml(String s) {
     if (s==null) return s;
     String str = new String(s);
     //str=strReplace(str,"\n","<br>");
     str=strReplace(str,"&","&amp;");
     str=strReplace(str,"<","&lt;");
     str=strReplace(str,">","&gt;");
     str=strReplace(str,"\"","&quot;");
     
     return str;
   }
   /**
    * ���ַ���sBody�е�sFrom��sTo�滻
    * @param sBody
    * @param sFrom
    * @param sTo
    * @return
    */
   public static String strReplace(String sBody, String sFrom, String sTo) {
      int i,j,k,l;
      if (sBody==null || sBody.equals("")) return "";
      i = 0;
      j = sFrom.length();
      k = sTo.length();
      StringBuffer sss = new StringBuffer(sBody.length());
      boolean bFirst=true;
      l = i;
      while (sBody.indexOf(sFrom,i)!=-1) {
        i = sBody.indexOf(sFrom,i);
        sss.append(sBody.substring(l,i));
        sss.append(sTo);
        i += j;
        l = i;
      }
      sss.append(sBody.substring(l));
      return sss.toString();
    }

 
      /**
     * ����ͨ�ַ�����ʽ�������ݿ��Ͽɵ��ַ�����ʽ
     *
     * @param str Ҫ��ʽ�����ַ���
     * @return �Ϸ������ݿ��ַ���
     */
    public static String toSql(String str) {
        str = strReplace(str, "'", "''");
        return str;
    }
      /**
     * ����ͨ�ַ���һ�ν������и�ʽ��
     *
     * @param str Ҫ��ʽ�����ַ���
     * @return �Ϸ������ݿ��ַ���
     */
     public static String parseAll(String body){
     	
     	String toStr = new String(body);
     	toStr = DataFormat.toHtml(toStr);
     	toStr = DataFormat.toSql(toStr);
     	return toStr;
     }
	 	    
}