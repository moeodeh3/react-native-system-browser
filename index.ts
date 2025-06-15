import { NativeModules } from 'react-native';

const { AuthBrowserModule } = NativeModules;

export const openAuthSession = async (url: string, scheme: string): Promise<string> => {
  return AuthBrowserModule.openAuth(url, scheme);
};
