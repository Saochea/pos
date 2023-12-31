import Dashboard from "../components/Dashboard";
import { useEffect, useState } from "react";
import { Spin, Space } from 'antd';
import { useAuth } from "../utls/auth";



const Home = () => {
  const auth = useAuth();
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (auth.isLoading) {
      setTimeout(() => {
        setLoading(false)
      }, 2000)
      auth.Loading(false)
    } else {
      setTimeout(() => {
        setLoading(false)
      }, 400)

    }
  }, [auth.isLoading])

  return (
    <>
      {loading ? (<div className='bg-gray-100 w-full h-screen absolute top-0'>
        <Space className='flex justify-center items-center h-screen bg-gray-100'>
          <Spin tip="Loading..." size="large">
            <div className='mr-12' />
          </Spin>
        </Space>
      </div>) : <Dashboard />}
    </>
  );
};

export default Home;
