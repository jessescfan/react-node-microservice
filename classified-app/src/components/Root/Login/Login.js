import {useMutation} from "@apollo/react-hooks";
import gql from "graphql-tag";
import React from "react";
import {useForm} from "react-hook-form";
import styled from "styled-components";
import TextInput from "#root/components/shared/TextInput";
import {setSession} from "#root/store/ducks/session";
import {useDispatch} from "react-redux";

const Label = styled.label`
  display: block;
  
  :not(:first-child) {
    margin-top: .75rem;
  }
`;

const OrSignUp = styled.span`
  font-size: .9rem;
`;

const LabelText = styled.strong`
  display: block;
  font-size: .9rem;
  margin-bottom: .25rem;
`;

const LoginButton = styled.button`
  display: inline-block;
  margin-top: .5rem;
`;

const mutation = gql`
  mutation($email: String!, $password: String!) {
    createUserSession(email: $email, password: $password) {
      id
      user {
        email
        id
      }
    }
  }
`;

const Login = ({onChangeToLogin: pushChangeToLogin}) => {
  const dispatch = useDispatch();
  const [createUserSession] = useMutation(mutation);

  const {
    formState: {isSubmitting},
    handleSubmit,
    register
  } = useForm();

  const onSubmit = handleSubmit(async ({ email, password }) => {
    const {
      data: { createUserSession: createdSession }
    } = await createUserSession({ variables: { email, password } });
    dispatch(setSession(createdSession));
  });

  return <form onSubmit={onSubmit}>
    <Label>
      <LabelText>Email</LabelText>
      <TextInput disabled={isSubmitting}
                 name="email"
                 type="email"
                 ref={register} />
    </Label>
    <Label>
      <LabelText>Password</LabelText>
      <TextInput disabled={isSubmitting}
                 name="password"
                 type="password"
                 ref={register} />
      <LoginButton disabled={isSubmitting} type="submit">
        Login
      </LoginButton>
      <OrSignUp> or {" "}
        <a href="#" onClick={evt => {
          evt.preventDefault();
          pushChangeToLogin();
        }}>
          Sign Up</a>
      </OrSignUp>
    </Label>
  </form>;
};

export default Login;