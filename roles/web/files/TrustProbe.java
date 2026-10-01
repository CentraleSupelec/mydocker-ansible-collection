import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.security.cert.CertificateException;
import java.time.Duration;
import javax.net.ssl.SSLException;

// Opens the URL the way the back checks environment readiness (TestSocket.isHttpsAlive):
// default HttpClient, so this JVM's default SSLContext and trust store.
// Exit 0 on any HTTP status, 2 when TLS validation fails, 3 when the host cannot be reached.
public class TrustProbe {
    public static void main(String[] args) throws InterruptedException {
        HttpRequest request = HttpRequest.newBuilder(URI.create(args[0]))
                .timeout(Duration.ofSeconds(10))
                .GET()
                .build();
        HttpClient client = HttpClient.newBuilder()
                .connectTimeout(Duration.ofSeconds(10))
                .build();
        try {
            HttpResponse<Void> response = client.send(request, HttpResponse.BodyHandlers.discarding());
            System.out.println("trusted: " + args[0] + " answered HTTP " + response.statusCode());
        } catch (IOException e) {
            for (Throwable cause = e; cause != null; cause = cause.getCause()) {
                if (cause instanceof SSLException || cause instanceof CertificateException) {
                    System.out.println("untrusted: " + args[0] + ": " + cause);
                    System.exit(2);
                }
            }
            System.out.println("unreachable: " + args[0] + ": " + e);
            System.exit(3);
        }
    }
}
