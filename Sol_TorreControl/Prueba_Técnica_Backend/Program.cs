using Prueba_Técnica_Backend.Data;
using System.Numerics;
using System.Data;
using Microsoft.AspNetCore.Mvc;
using Prueba_Técnica_Backend;
using Plane = Prueba_Técnica_Backend.Data.Plane;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.MapGet("/DatosDeVuelo", (int flight_no) => //Endpoint par obtener un vuelo/avión en especifico
{
    return PlaneData.DatosVuelo(flight_no);
});

app.MapPost("/RegistrarVuelo/oPlane", ([FromBody] Registro oRegist) => //Endpoint para crear vuelo/avión
{
    return PlaneData.Registrar(oRegist);
});

app.MapDelete("/CancelarVuelo/{id}", (int id) => //Endpoint para eliminar el vuelo/avión
{
    return PlaneData.Cancelar(id);
});

app.MapPut("/BuscarVuelo", (Pasajero oPasajero) => //Endpoint par obtener verificar si hay vuelos/aviones disponibles a la hora que desea
{
    return PlaneData.BuscarVuelos(oPasajero);
});

app.MapPut("/ComprarVuelo", (Pasajero oPasajero) => //Endpoint para crear pasajero 
{
    return PlaneData.ComprarVuelo(oPasajero);
});

app.MapPut("/CrearAeropuerto", (Airport oAirport) => //Endpoint para crear un nuevo aeropuerto
{
    return PlaneData.CrearAeropuerto(oAirport);
}); 

app.Run();

