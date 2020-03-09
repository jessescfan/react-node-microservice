import {get} from "lodash";

const formatGraphQLErrors = error => {
    // const errorDetails =  get(error,"originalError.response.body");
    // const errorDetails =  get(error,"GraphQLError");
    //
    // try {
    //     if (error) return JSON.parse(error.message);
    // } catch (e) {}

    return error;
};

export default formatGraphQLErrors;