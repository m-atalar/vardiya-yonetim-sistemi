"use client";

import { useEffect, useState } from "react";

interface Employee {
  id: number;
  name: string;
  email: string;
  role: string;
}

interface ShiftAssignment {
  id: number;
  date: string;
  status: string;
  employee: {
    id: number;
    name: string;
  };
}

interface Shift {
  id: number;
  name: string;
  start_time: string;
  end_time: string;
  description: string;
  employees: Employee[];
  shift_assignments: ShiftAssignment[];
}

export default function Home() {
  const [shifts, setShifts] = useState<Shift[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchShifts = async () => {
      try {
        const response = await fetch("http://localhost:3000/api/v1/shifts");
        if (!response.ok) {
          throw new Error("Failed to fetch shifts");
        }
        const data = await response.json();
        setShifts(data);
      } catch (err) {
        setError(err instanceof Error ? err.message : "An error occurred");
      } finally {
        setLoading(false);
      }
    };

    fetchShifts();
  }, []);

  if (loading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 p-8 flex items-center justify-center">
        <p className="text-xl text-gray-700">Loading shifts...</p>
      </div>
    );
  }

  if (error) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 p-8 flex items-center justify-center">
        <p className="text-xl text-red-600">Error: {error}</p>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 p-8">
      <div className="max-w-7xl mx-auto">
        <div className="mb-8">
          <h1 className="text-5xl font-bold text-gray-900 mb-3">
            Vardiya Yönetim Sistemi
          </h1>
          <p className="text-xl text-gray-600">
            Çalışan vardiya planlama ve yönetim platformu
          </p>
          <div className="mt-4 inline-block bg-indigo-600 text-white px-4 py-2 rounded-lg shadow-md">
            <span className="font-semibold">{shifts.length} Vardiya Aktif</span>
          </div>
        </div>

        <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3" data-testid="shifts-list">
          {shifts.map((shift) => (
            <div
              key={shift.id}
              data-testid="shift-item"
              className="bg-white rounded-lg shadow-md p-6 hover:shadow-xl transition-shadow duration-300 border border-gray-200"
            >
              <h2
                data-testid="shift-name"
                className="text-2xl font-bold text-gray-900 mb-3"
              >
                {shift.name}
              </h2>

              <div className="mb-4 bg-indigo-50 rounded-md p-3">
                <p data-testid="shift-time" className="text-indigo-700 font-semibold text-lg">
                  ⏰ {shift.start_time.substring(0, 5)} - {shift.end_time.substring(0, 5)}
                </p>
              </div>

              {shift.description && (
                <p
                  data-testid="shift-description"
                  className="text-gray-600 mb-4"
                >
                  {shift.description}
                </p>
              )}

              <div className="border-t border-gray-200 pt-4 mt-4">
                <h3 className="font-semibold text-gray-800 mb-3">
                  👥 Atanan Çalışanlar
                </h3>
                {shift.employees && shift.employees.length > 0 ? (
                  <div className="space-y-2">
                    {shift.employees.map((employee) => (
                      <div
                        key={employee.id}
                        data-testid="shift-employee"
                        className="bg-gray-50 rounded-md p-3"
                      >
                        <p className="font-medium text-gray-900">{employee.name}</p>
                        <p className="text-sm text-gray-500 capitalize">{employee.role}</p>
                      </div>
                    ))}
                  </div>
                ) : (
                  <p className="text-sm text-gray-500 italic">
                    Henüz atama yapılmamış
                  </p>
                )}
              </div>

              {shift.shift_assignments && shift.shift_assignments.length > 0 && (
                <div className="border-t border-gray-200 pt-4 mt-4">
                  <h3 className="font-semibold text-gray-800 mb-3">
                    📅 Son Atamalar
                  </h3>
                  <div className="space-y-2">
                    {shift.shift_assignments.slice(0, 3).map((assignment) => (
                      <div
                        key={assignment.id}
                        className="flex justify-between items-center bg-indigo-50 rounded-md p-2"
                      >
                        <span className="text-gray-700 font-medium text-sm">{assignment.employee.name}</span>
                        <span className="text-indigo-600 text-sm">
                          {new Date(assignment.date).toLocaleDateString("tr-TR")}
                        </span>
                      </div>
                    ))}
                  </div>
                </div>
              )}
            </div>
          ))}
        </div>

        {shifts.length === 0 && (
          <div className="text-center py-12">
            <p className="text-xl text-gray-600">
              No shifts available. Please add some shifts first.
            </p>
          </div>
        )}
      </div>
    </div>
  );
}
