package cocoFarm.util.runners;

import static java.lang.annotation.ElementType.METHOD;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Retention(RetentionPolicy.RUNTIME)
@Target(METHOD)
public @interface Run {
	public long maxSleep() default 21600000L;
	public long minSleep() default 60000L;
	public int runTest() default 1;
}
