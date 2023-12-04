import java.util.Hashtable;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

import dao.IDao;
import entities.Ville;

public class TestVille {

	public static IDao<Ville> lookUpEmployeRemote() throws NamingException {
		final Hashtable<String, String> jndiProperties = new Hashtable<String, String>();
		jndiProperties.put(Context.INITIAL_CONTEXT_FACTORY, "org.wildfly.naming.client.WildFlyInitialContextFactory");
		jndiProperties.put(Context.PROVIDER_URL, "http-remoting://localhost:8080");
final Context context = new InitialContext(jndiProperties);

		return (IDao<Ville>) context.lookup("ejb:ISICEJBEAR/ISICEJBServer/kenza!dao.IDao");

	}
	public static void main(String[] args) {
		
		try {
			IDao<Ville> dao = lookUpEmployeRemote();
			dao.create(new Ville("EL JADIDA"));
			dao.create(new Ville("Marrakech"));
			dao.create(new Ville("Casablanca"));
			
			for(Ville v : dao.findAll()) {
				System.out.println(v.getNom());
			}
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		

	}
}