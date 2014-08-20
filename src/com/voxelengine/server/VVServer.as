package com.voxelengine.server 
{
	import com.voxelengine.Globals;
	import com.voxelengine.events.LoginEvent;
	import com.voxelengine.events.RegionEvent;
	import playerio.Client;
	import playerio.Connection;
	import playerio.PlayerIO;
	import playerio.PlayerIOError;
	import playerio.Message;
	
	public class VVServer
	{
		static private var _connection:Connection = null;
		static public function connection():Connection { return _connection; }
		
		static public var regionName:String;
/*		
		static public function connect( email:String, password:String ):void
		{
			PlayerIO.connect(
				Globals.g_app.stage,				//Referance to stage
				"voxelverse-lpeje46xj0krryqaxq0vog",//Game id (Get your own at playerio.com)
				"public",							//Connection id, default is public
				email,								//Username
				"",									//User auth. Can be left blank if authentication is disabled on connection
				null,								//Current PartnerPay partner.
				connectSuccess,						//Function executed on successful connect
				connectFailure					//Function executed if we recive an error
			);   
		}
*/		
		static public function joinRoom( $regionName:String ):void
		{
			//trace("VVServer.connectSuccess - connection to server established");
			//
			//Set developmentsever (Comment out to connect to your server online)
			//$client.multiplayer.developmentServer = "localhost:8184";
			//Network.userId = $client.connectUserId;
			//Network.client = $client
			//Set developmentsever (Comment out to connect to your server online)
			trace( "joinRoom: " + Network.client.multiplayer.developmentServer );
			Network.client.multiplayer.developmentServer = "localhost:8184";
			trace( "joinRoom: " + Network.client.multiplayer.developmentServer );
			
			
			regionName = $regionName;
			
			trace("VVServer.joinRoom - trying to join room at host: " + Network.client.multiplayer.developmentServer );
			//Create pr join the room test
			Network.client.multiplayer.createJoinRoom(
				regionName,							//Room id. If set to null a random roomid is used
				"VoxelVerse",							//The game type started on the server
				true,								//Should the room be visible in the lobby?
				{},									//Room data. This data is returned to lobby list. Variabels can be modifed on the server
				{},									//User join data
				handleJoin,							//Function executed on successful joining of the room
				handleJoinError						//Function executed if we got a join error
			);
		}
		
		static public function connectFailure(error:PlayerIOError):void
		{
			trace("VVServer.handleConnectError",error)
		}
		
		static private function handleJoin(connection:Connection):void
		{
			
			Globals.g_app.dispatchEvent( new RegionEvent( RegionEvent.REGION_PERSISTANCE_LOAD, regionName ) );
			
			trace("VVServer.handleJoin. Sucessfully joined Room");
			_connection = connection;
			
			//Add disconnect listener
			_connection.addDisconnectHandler(handleDisconnect);
			
			EventHandlers.addEventHandlers( _connection );
		}
		
		static private function handleMessages(m:Message):void
		{
			trace("VVServer.handleMessages - Received * message", m)
		}
		
		static private function handleDisconnect():void
		{
			trace("Disconnected from server")
		}
		
		static private function handleJoinError(error:PlayerIOError):void
		{
			trace("VVServer.handleJoinError",error)
			Globals.g_app.dispatchEvent( new LoginEvent( LoginEvent.LOGIN_FAILURE, error ) );
		}
	}	
}
