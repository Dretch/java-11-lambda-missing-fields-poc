package com.garethdanielsmith;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;

public class TestLambda implements RequestHandler<String,TestParent> {

  @Override
  public TestParent handleRequest(String input, Context context) {
    return new TestChild();
  }
}
