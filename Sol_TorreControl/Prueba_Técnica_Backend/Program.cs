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

app.MapGet("/DatosDeVuelo", (int flight_no) =>
{

    return PlaneData.DatosVuelo(flight_no);

});

app.MapPost("/RegistrarVuelo/oPlane", ([FromBody] Registro oRegist) =>
{
    return PlaneData.Registrar(oRegist);
});

app.MapDelete("/CancelarVuelo/{id}", (int id) =>
{
    return PlaneData.Cancelar(id);
});

app.MapPut("/BuscarVuelo", (Pasajero oPasajero) =>
{
    return PlaneData.BuscarVuelos(oPasajero);
});

app.MapPut("/ComprarVuelo", (Pasajero oPasajero) =>
{
    return PlaneData.ComprarVuelo(oPasajero);
});

app.Run();

